﻿
////////////////////////////////////////////////////////////////////////////////
// ВалидаторПакетов  
////////////////////////////////////////////////////////////////////////////////
#Область ОписаниеПеременных
Перем ШаблонБазовойОшибки; // Базовый текст ошибки
#КонецОбласти

#Область ПрограммныйИнтерфейс

// Возвращает список ошибок модели данных.
//
// Параметры:
//  МодельДанных - Структура - Проверяемый объект.
//               - Массив   - Проверяемый объект.
//  ИмяСхемы     - Строка - Имя схемы данных из спецификации.
//  СпецификацияСтрокой - Строка - Спецификация OpenAPI 3.0 в формате JSON.
// 
// Возвращаемое значение:
//  Массив - Список ошибок.
//
Функция Валидировать(Знач МодельДанных, Знач ИмяСхемы, Знач СпецификацияСтрокой) Экспорт // BSLLS:Typo-off
	Ошибки = Новый Массив;
	Спецификация = СпецификацияСтрокой;
	
	СхемыДанныхСпецификации = ВалидаторПакетовПовтИсп.СхемыДанныхСпецификации(Спецификация);

	КлючИЗначение = Новый Структура("Ключ, Значение", ИмяСхемы, МодельДанных);
	
	ПроверитьСвойствоПоСхеме(КлючИЗначение, СхемыДанныхСпецификации, Ложь);
	
	Возврат Ошибки;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции
Процедура ПроверитьСвойствоПоСхеме(Данные,
									ТекущийКонтекст,
									ОписаниеДополнительныхСвойств = Истина)
		
	ПроверяемаяСхема = ПолучитьПроверяемуюСхему(Данные.Ключ, ТекущийКонтекст);
	Если ПроверяемаяСхема = Неопределено Тогда
		// Это доп.свойство
		ПроверяемаяСхема = ПолучитьСхемуДополнительныхСвойств(ОписаниеДополнительныхСвойств, Данные.Ключ);
		
		Если Не ЗначениеЗаполнено(ПроверяемаяСхема) Тогда
			Возврат;
		КонецЕсли;
	КонецЕсли;
	
	ВыполнитьВалидациюДанных(Данные, ПроверяемаяСхема);
КонецПроцедуры

Функция ПолучитьСхемуДополнительныхСвойств(ОписаниеДополнительныхСвойств, ИмяСвойства)
	
	Если ОписаниеДополнительныхСвойств = Ложь Тогда
		// Доп.свойства нельзя, но схему не нашли. Зафиксируем ошибку.
		ТекстОшибки = СтрШаблон("Не удалось найти свойство <%1> в схеме данных.", ИмяСвойства);
		Ошибки.Добавить(ТекстОшибки);
		Возврат Неопределено;
	КонецЕсли;

	Если ОписаниеДополнительныхСвойств = Истина Тогда
		Возврат Неопределено;
	КонецЕсли;

	Возврат РазыменоватьСхему(ОписаниеДополнительныхСвойств);
КонецФункции

Процедура ВыполнитьВалидациюДанных(Данные, ПроверяемаяСхема)
	Если ЭтоСложнаяСхема(ПроверяемаяСхема) Тогда
		ОбработатьСложнуюСхему(Данные, ПроверяемаяСхема);
	Иначе
		ВалидироватьДанныеПоСхеме(Данные, ПроверяемаяСхема);
	КонецЕсли;
КонецПроцедуры

Процедура ВалидироватьДанныеПоСхеме(Данные, ПроверяемаяСхема)
	УстановитьШаблонБазовойОшибки(Данные.Ключ,
									ПроверяемаяСхема.Получить("description"));
	Если Данные.Значение = Неопределено Тогда
		nullable = ПроверяемаяСхема.Получить("nullable");
		Если Не nullable = Истина Тогда
			ТекстОшибки = СтрШаблон("Свойство <%1> объявлено, и должно быть заполнено, но это не так", Данные.Ключ);
			Ошибки.Добавить(ТекстОшибки);
		КонецЕсли;
		
		Возврат;
	КонецЕсли;
	
	Тип = ПроверяемаяСхема.Получить("type");
	Если Тип = Неопределено Тогда
		// Это anytype тут может быть все что угодно и это валидно.
		// см. https://swagger.io/docs/specification/v3_0/data-models/data-types/#any-type
		Возврат;
	КонецЕсли;

	Если Тип = "string" Тогда
		ВалидироватьСтроку(Данные, ПроверяемаяСхема);
	ИначеЕсли Тип = "number" ИЛИ Тип = "integer" Тогда
		ВалидироватьЧисло(Данные, ПроверяемаяСхема);
	ИначеЕсли Тип = "array" Тогда
		ВалидироватьМассив(Данные, ПроверяемаяСхема);
	ИначеЕсли Тип = "object" Тогда
		ВалидироватьОбъект(Данные, ПроверяемаяСхема);
	ИначеЕсли Тип = "boolean" Тогда
		ВалидироватьБулево(Данные, ПроверяемаяСхема);
	Иначе
		ТекстОшибки = СтрШаблон("Ошибка при разборе схемы! Задано некорректное значение типа в <%1>",
									Данные.Значение);
		ЗаписьЖурналаРегистрации("ВалидаторПакетов",
										УровеньЖурналаРегистрации.Ошибка, , ,
										ТекстОшибки);
		ВызватьИсключение ТекстОшибки;
	КонецЕсли;
КонецПроцедуры

#Область РаботаСоСложнымиСхемами
Процедура ОбработатьСложнуюСхему(Данные, ПроверяемаяСхема)
	// Для работы сложных схем, нам понадобятся промежуточные результаты валидации.
	// Закэшируем накопленные ошибки, а после выполнения проверок вернем их на место.
	КэшОшибок = Новый Массив;
	ДополнитьМассив(КэшОшибок, Ошибки);
	Если ЕстьСвойство("oneOf", ПроверяемаяСхема) Тогда
		ОбработатьСвойствоOneOf(Данные, ПроверяемаяСхема.Получить("oneOf"));
	ИначеЕсли ЕстьСвойство("anyOf", ПроверяемаяСхема) Тогда
		ОбработатьСвойствоAnyOf(Данные, ПроверяемаяСхема.Получить("anyOf"));
	ИначеЕсли ЕстьСвойство("allOf", ПроверяемаяСхема) Тогда
		ОбработатьСвойствоAllOf(Данные, ПроверяемаяСхема.Получить("allOf"));
	Иначе
		// Тут такого быть категорически не должно! Это ошибка валидатора.
		ВызватьИсключение "Ошибка при разборе схемы! Не найдено ни одного из свойств oneOf, anyOf, allOf.";
	КонецЕсли;
	
	ДополнитьМассив(Ошибки, КэшОшибок);
КонецПроцедуры

Процедура ОбработатьСвойствоOneOf(Данные, МассивПроверяемыхСхем)
	МассивИндексовСхемПрошедшихВалидацию = Новый Массив;
	ПромежуточныйКэшОшибок = Новый Массив;
	Для Индекс = 0 По МассивПроверяемыхСхем.ВГраница() Цикл
		ПроверяемаяСхема = РазыменоватьСхему(МассивПроверяемыхСхем[Индекс]);
	    Ошибки = Новый Массив;
		ВыполнитьВалидациюДанных(Данные, ПроверяемаяСхема);
		Если Ошибки.Количество() = 0  Тогда
	    	МассивИндексовСхемПрошедшихВалидацию.Добавить(Индекс);
		КонецЕсли;
		Если МассивИндексовСхемПрошедшихВалидацию.Количество() > 1 Тогда
			// Уже была успешная валидация по схеме, а значит это ошибка oneOf
			ТекстОшибки = СтрШаблон("%1 <oneOf> Объект должен соответствовать только одной схеме. Индексы валидных схем <%2>",
									ШаблонБазовойОшибки, СтрСоединить(МассивИндексовСхемПрошедшихВалидацию, ";"));
			Ошибки.Добавить(ТекстОшибки);
			Возврат;
		КонецЕсли;
		
		ДополнитьМассив(ПромежуточныйКэшОшибок, Ошибки);
	КонецЦикла;
	
	Если МассивИндексовСхемПрошедшихВалидацию.Количество() = 0 Тогда
		
		ТекстОшибки = СтрШаблон("%1 <oneOf> Объект должен соответствовать хотя бы одной схеме.",
									ШаблонБазовойОшибки);
		Ошибки.Добавить(ТекстОшибки);
		ДополнитьМассив(Ошибки, ПромежуточныйКэшОшибок);
		Возврат;
	КонецЕсли;
	// Ровно одна схема прошла валидацию. Очистим массив ошибок, т.к. все ок. :)
	Ошибки = Новый Массив;
	
КонецПроцедуры

Процедура ОбработатьСвойствоAnyOf(Данные, МассивПроверяемыхСхем)
	ПромежуточныйКэшОшибок = Новый Массив;
	Для Индекс = 0 По МассивПроверяемыхСхем.ВГраница() Цикл
		ПроверяемаяСхема = РазыменоватьСхему(МассивПроверяемыхСхем[Индекс]);
	    Ошибки = Новый Массив;
		ВыполнитьВалидациюДанных(Данные, ПроверяемаяСхема);
		Если Ошибки.Количество() = 0  Тогда
			Возврат;
		КонецЕсли;
		ДополнитьМассив(ПромежуточныйКэшОшибок, Ошибки);
	КонецЦикла;
	
	Ошибки = Новый Массив;
	ТекстОшибки = СтрШаблон("%1 <anyOf> Объект должен соответствовать хотя бы одной схеме.",
							ШаблонБазовойОшибки);
	Ошибки.Добавить(ТекстОшибки);
	ДополнитьМассив(Ошибки, ПромежуточныйКэшОшибок);
	
КонецПроцедуры

Процедура ОбработатьСвойствоAllOf(Данные, МассивПроверяемыхСхем)
	Ошибки = Новый Массив;
	Для Индекс = 0 По МассивПроверяемыхСхем.ВГраница() Цикл
		ПроверяемаяСхема = РазыменоватьСхему(МассивПроверяемыхСхем[Индекс]);
		
		ВыполнитьВалидациюДанных(Данные, ПроверяемаяСхема);
	КонецЦикла;
	
	Если Ошибки.Количество() > 0  Тогда
		ТекстОшибки = СтрШаблон("%1 <allOf> Объект должен соответствовать всем схемам.",
								ШаблонБазовойОшибки);
		Ошибки.Добавить(ТекстОшибки);
	КонецЕсли;
КонецПроцедуры
#КонецОбласти

#Область ВалидацияСтроки
Процедура ВалидироватьСтроку(Данные, ПроверяемаяСхема)
	
	ОписаниеТипа = СоздатьОписаниеТиповПриПроверкеСтроки(ПроверяемаяСхема);
	ЗначениеСвойства = Данные.Значение;
		
	Если Не ТипЗначенияСоответствуетОписанию(ЗначениеСвойства, ОписаниеТипа) Тогда
		Возврат;
	КонецЕсли;
	
	ПроверитьМинимальнуюДлину(ЗначениеСвойства, ПроверяемаяСхема);
	
	ПроверитьСтрокуНаСоответствиеФорматуИПаттерну(ЗначениеСвойства,
													ПроверяемаяСхема);
	ПроверитьСоответствиеПеречислению(ЗначениеСвойства, ПроверяемаяСхема);
КонецПроцедуры

Функция СоздатьОписаниеТиповПриПроверкеСтроки(ПроверяемаяСхема)
	ОписаниеТипа = Новый ОписаниеТипов("Строка");
	МаксимальнаяДлина = ПроверяемаяСхема.Получить("maxLength");
	Если Не МаксимальнаяДлина = Неопределено Тогда
		КвалификаторСтроки = Новый КвалификаторыСтроки(МаксимальнаяДлина);
		ОписаниеТипа = Новый ОписаниеТипов(ОписаниеТипа, , , , КвалификаторСтроки);
	КонецЕсли;
	Формат =  ПроверяемаяСхема.Получить("format");
	Если Формат = "date" Тогда
		КвалификаторДаты = Новый КвалификаторыДаты(ЧастиДаты.Дата);
		ОписаниеТипа = Новый ОписаниеТипов(ОписаниеТипа, "Дата", , , , КвалификаторДаты);
	ИначеЕсли Формат = "date-time" Тогда
		КвалификаторДаты = Новый КвалификаторыДаты(ЧастиДаты.ДатаВремя);
		ОписаниеТипа = Новый ОписаниеТипов(ОписаниеТипа, "Дата", , , , КвалификаторДаты);
	ИначеЕсли Формат = "uuid" Тогда
		ОписаниеТипа = Новый ОписаниеТипов(ОписаниеТипа, "УникальныйИдентификатор");
	КонецЕсли; // BSLLS:IfElseIfEndsWithElse-off
	
Возврат ОписаниеТипа;
КонецФункции

Процедура ПроверитьСтрокуНаСоответствиеФорматуИПаттерну(ЗначениеСвойства, ПроверяемаяСхема)
	ФорматЗначения = ПроверяемаяСхема.Получить("format");
	Паттерн = ПроверяемаяСхема.Получить("pattern");
// BSLLS:LineLength-off
	Если ФорматЗначения = "byte" Тогда
		ПроверитьBase64(ЗначениеСвойства);
	ИначеЕсли ФорматЗначения = "date" Тогда
		ПроверитьДату(ЗначениеСвойства, ЧастиДаты.Дата);
	ИначеЕсли ФорматЗначения = "date-time" Тогда
		ПроверитьДату(ЗначениеСвойства, ЧастиДаты.ДатаВремя);;
	ИначеЕсли ФорматЗначения = "email" Тогда
		Паттерн = "^((?!\.)[\w\-_.]*[^.])(@\w+)(\.\w+(\.\w+)?[^.\W])$";
	ИначеЕсли ФорматЗначения = "uuid" Тогда
		Паттерн = "[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}";
	ИначеЕсли ФорматЗначения = "uri" Тогда
		Паттерн = "^(((ht|f)tp(s?)\:\/\/[0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*(:(0-9)*)*))?(\/?)(\{?)([a-zA-Z0-9\-\.\?\,\'\/\\\+\~\{\}\&%\$#_]*)?(\}?)(\/?)$"; // BSLLS:LineLength-off
	ИначеЕсли ФорматЗначения = "ipv4" Тогда
		Паттерн = "^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$";
	ИначеЕсли ФорматЗначения = "ipv6" Тогда
		Паттерн = "^([[:xdigit:]]{1,4}(?::[[:xdigit:]]{1,4}){7}|::|:(?::[[:xdigit:]]{1,4}){1,6}|[[:xdigit:]]{1,4}:(?::[[:xdigit:]]{1,4}){1,5}|(?:[[:xdigit:]]{1,4}:){2}(?::[[:xdigit:]]{1,4}){1,4}|(?:[[:xdigit:]]{1,4}:){3}(?::[[:xdigit:]]{1,4}){1,3}|(?:[[:xdigit:]]{1,4}:){4}(?::[[:xdigit:]]{1,4}){1,2}|(?:[[:xdigit:]]{1,4}:){5}:[[:xdigit:]]{1,4}|(?:[[:xdigit:]]{1,4}:){1,6}:)$";
	Иначе
		ФорматЗначения = "pattern";
	КонецЕсли;
// BSLLS:LineLength-on
	Если ЗначениеЗаполнено(Паттерн) Тогда
		ПроверитьПоРегулярномуВыражению(ЗначениеСвойства, Паттерн, ФорматЗначения);
	КонецЕсли;
	
КонецПроцедуры

Процедура ПроверитьДату(Значение, ОписаниеЧастиДаты)
	ОписаниеДаты = Новый ОписаниеТипов("Дата", , , , , Новый КвалификаторыДаты(ОписаниеЧастиДаты));
	Попытка
		Дата = ПрочитатьДатуJSON(Значение, ФорматДатыJSON.ISO);
		ПриведеннаяДата = ОписаниеДаты.ПривестиЗначение(Дата);
	Исключение
		ОписаниеПроблемы = СтрШаблон("Неверный формат. Не удалось привести значение <%1>, к дате.",
										Значение);
		ТекстОшибки = СтрШаблон("%1 %2", ШаблонБазовойОшибки, ОписаниеПроблемы);
		Ошибки.Добавить(ТекстОшибки);
		Возврат;
	КонецПопытки;
	
	Если Не Дата = ПриведеннаяДата Тогда
		ОписаниеПроблемы = СтрШаблон("Неверный формат даты. Ожидается строка в формате <%1>",
										ОписаниеЧастиДаты);
		ТекстОшибки = СтрШаблон("%1 %2", ШаблонБазовойОшибки, ОписаниеПроблемы);
		Ошибки.Добавить(ТекстОшибки);
		Возврат;
	КонецЕсли;
КонецПроцедуры

Процедура ПроверитьПоРегулярномуВыражению(Значение, Паттерн, Формат)
	Если Не СтрПодобнаПоРегулярномуВыражению(Значение, Паттерн) Тогда
			ПредставлениеОшибки = СтрШаблон("%1 Ожидался формат %2.",
										ШаблонБазовойОшибки, Формат);
			Ошибки.Добавить(ПредставлениеОшибки);
	КонецЕсли;
КонецПроцедуры

Процедура ПроверитьBase64(Значение)
		Если Не ЗначениеЗаполнено(Base64Значение(Значение)) Тогда
			ПредставлениеОшибки = СтрШаблон("%1 Ожидалось Base64 значение.",
										ШаблонБазовойОшибки);
			Ошибки.Добавить(ПредставлениеОшибки);
		КонецЕсли;
КонецПроцедуры

Процедура ПроверитьМинимальнуюДлину(ЗначениеСвойства, ПроверяемаяСхема)
	МинимальнаяДлина = ПроверяемаяСхема.Получить("minLength");
	Если Не МинимальнаяДлина = Неопределено И СтрДлина(ЗначениеСвойства) < МинимальнаяДлина Тогда
		ТекстОшибки = СтрШаблон("%1. Длина, меньше требуемой. Минимальная длина <%2>",
									ШаблонБазовойОшибки, МинимальнаяДлина);
		Ошибки.Добавить(ТекстОшибки);
	КонецЕсли;
КонецПроцедуры

Процедура ПроверитьСоответствиеПеречислению(ЗначениеСвойства, ПроверяемаяСхема)
	ЗначенияПеречисления = ПроверяемаяСхема.Получить("enum");
	Если ЗначенияПеречисления = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если ЗначенияПеречисления.Найти(ЗначениеСвойства) = Неопределено Тогда
		ПредставлениеПеречисления = СтрСоединить(ЗначенияПеречисления, ";");
		ТекстДеталей = СтрШаблон("Значение <%1> не найдено среди доступных вариантов. Список доступных значений: %2"
									, ЗначениеСвойства, ПредставлениеПеречисления);
		ТекстОшибки = СтрШаблон("%1 %2",
									ШаблонБазовойОшибки,
									ТекстДеталей);
		Ошибки.Добавить(ТекстОшибки);
	КонецЕсли;
КонецПроцедуры
#КонецОбласти

#Область ВалидацияЧисла
Процедура ВалидироватьЧисло(Данные, ПроверяемаяСхема)
	ОписаниеТипа = СоздатьОписаниеТиповПриПроверкеЧисла(ПроверяемаяСхема);
	ЗначениеСвойства = Данные.Значение;

	Если Не ТипЗначенияСоответствуетОписанию(ЗначениеСвойства, ОписаниеТипа) Тогда
		Возврат;
	КонецЕсли;
		
	ПроверитьМинимум(ЗначениеСвойства, ПроверяемаяСхема);
	
	ПроверитьМаксимум(ЗначениеСвойства, ПроверяемаяСхема);
	
	ПроверитьКратность(ЗначениеСвойства, ПроверяемаяСхема);
КонецПроцедуры

Функция СоздатьОписаниеТиповПриПроверкеЧисла(ПроверяемаяСхема)
	ОписаниеТипа = Новый ОписаниеТипов("Число");
	Если ПроверяемаяСхема.Получить("type") = "integer" Тогда
		МаксимальнаяРазрядностьЧисла = 20;
		ОписаниеТипа = Новый ОписаниеТипов(ОписаниеТипа, , ,  Новый КвалификаторыЧисла(МаксимальнаяРазрядностьЧисла, 0));
	КонецЕсли;
	
	Возврат ОписаниеТипа;
КонецФункции

Процедура ПроверитьМинимум(ЗначениеСвойства, ПроверяемаяСхема)
	МинимальноеЗначение = ПроверяемаяСхема.Получить("minimum");
	Если  МинимальноеЗначение = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Включая = Не ПроверяемаяСхема.Получить("exclusiveMinimum") = Истина;
	Если МинимальноеЗначение > ЗначениеСвойства
		ИЛИ (Включая И МинимальноеЗначение = ЗначениеСвойства) Тогда
		ТекстОшибки = СтрШаблон("%1 Значение <%2> должно быть больше %3<%4>",
								ШаблонБазовойОшибки,
								ЗначениеСвойства,
								?(Включая, "или равно ", ""),
								МинимальноеЗначение);
		Ошибки.Добавить(ТекстОшибки);
	КонецЕсли;
КонецПроцедуры

Процедура ПроверитьМаксимум(ЗначениеСвойства, ПроверяемаяСхема)
	МаксимальноеЗначение = ПроверяемаяСхема.Получить("maximum");
	Если МаксимальноеЗначение = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Включая = Не ПроверяемаяСхема.Получить("exclusiveMaximum") = Истина;
	Если МаксимальноеЗначение < ЗначениеСвойства
		ИЛИ (Включая И МаксимальноеЗначение = ЗначениеСвойства) Тогда
		ТекстОшибки = СтрШаблон("%1 Значение <%2> должно быть меньше %3<%4>",
								ШаблонБазовойОшибки,
								ЗначениеСвойства,
								?(Включая, "или равно ", ""),
								МаксимальноеЗначение);
		Ошибки.Добавить(ТекстОшибки);
	КонецЕсли;
	
КонецПроцедуры

Процедура ПроверитьКратность(ЗначениеСвойства, ПроверяемаяСхема)
	Кратность = ПроверяемаяСхема.Получить("multipleOf");
	Если Кратность = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если Кратность = 0 Тогда
		ВызватьИсключение "Ошибка в схеме! Кратность не может быть равна нулю!";
	КонецЕсли;
		
	Если Не ЗначениеСвойства % Кратность = 0 Тогда
		ТекстОшибки = СтрШаблон("%1 Значение <%2> должно быть кратно <%3>",
								ШаблонБазовойОшибки,
								ЗначениеСвойства,
								Кратность);
		Ошибки.Добавить(ТекстОшибки);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ВалидацияМассива
Процедура ВалидироватьМассив(Данные, ПроверяемаяСхема)
	ОписаниеТипа = Новый ОписаниеТипов("Массив");
	ЗначениеСвойства = Данные.Значение;
	
	Если Не ТипЗначенияСоответствуетОписанию(ЗначениеСвойства, ОписаниеТипа) Тогда
		Возврат;
	КонецЕсли;
	
	ПроверитьМинимумИМаксимумСтрок(ЗначениеСвойства, ПроверяемаяСхема);
	
	ПроверитьУникальностьЗначений(ЗначениеСвойства, ПроверяемаяСхема);
	
	Для Каждого ЭлементМассива Из ЗначениеСвойства Цикл
		СтруктураЭлемента = Новый Структура("Ключ, Значение", "items", ЭлементМассива);
		ПроверитьСвойствоПоСхеме(СтруктураЭлемента, ПроверяемаяСхема, Ложь);
	КонецЦикла;
КонецПроцедуры

Процедура ПроверитьМинимумИМаксимумСтрок(ПроверяемыйМассив, ПроверяемаяСхема)
	
	МинимумСтрок = ПроверяемаяСхема.Получить("minItems");
	Если Не МинимумСтрок = Неопределено И ПроверяемыйМассив.Количество() < МинимумСтрок Тогда
		ТекстДеталей = СтрШаблон("Количество элементов массива <%1> меньше минимального порога <%2>",
									ПроверяемыйМассив.Количество(),
									МинимумСтрок);
		ТекстОшибки = СтрШаблон("%1 %2", ШаблонБазовойОшибки, ТекстДеталей);
		Ошибки.Добавить(ТекстОшибки);
		Возврат;
	КонецЕсли;
	
	МаксимумСтрок = ПроверяемаяСхема.Получить("maxItems");
	Если Не МаксимумСтрок = Неопределено И ПроверяемыйМассив.Количество() > МаксимумСтрок Тогда
		ТекстДеталей = СтрШаблон("Количество элементов массива <%1> больше максимального порога <%2>",
									ПроверяемыйМассив.Количество(),
									МаксимумСтрок);
		ТекстОшибки = СтрШаблон("%1 %2", ШаблонБазовойОшибки, ТекстДеталей);
		Ошибки.Добавить(ТекстОшибки);
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

Процедура ПроверитьУникальностьЗначений(ПроверяемыйМассив, ПроверяемаяСхема)
	УникальныеЗначения = ПроверяемаяСхема.Получить("uniqueItems");
	
	Если Не УникальныеЗначения = Истина Тогда
		Возврат;
	КонецЕсли;
	
	СвернутыйМассив =  СвернутьМассив(ПроверяемыйМассив);
	
	Если Не СвернутыйМассив.Количество() = ПроверяемыйМассив.Количество() Тогда
		ТекстОшибки = СтрШаблон("%1 Значения в массиве не уникальны!", ШаблонБазовойОшибки);
		Ошибки.Добавить(ТекстОшибки);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ВалидацияОбъекта
Процедура ВалидироватьОбъект(Данные, ПроверяемаяСхема) // BSLLS:Typo-off
	ОписаниеТипа = Новый ОписаниеТипов("Структура,Соответствие");
	ЗначениеСвойства = Данные.Значение;
	
	Если Не ТипЗначенияСоответствуетОписанию(ЗначениеСвойства, ОписаниеТипа) Тогда
		Возврат;
	КонецЕсли;
	
	ПроверитьНаличиеОбязательныхСвойств(ЗначениеСвойства, ПроверяемаяСхема);
	
	ПроверитьКоличествоСвойств(ЗначениеСвойства, ПроверяемаяСхема);

	ОписаниеДополнительныхСвойств =  ПроверяемаяСхема.Получить("additionalProperties");
	
	СписокСвойств = ПроверяемаяСхема.Получить("properties");
	Если СписокСвойств = Неопределено Тогда
		// Если свойства не определены - значит все свойства что есть, дополнительные.
		// Передадим пустое соответсвие в качестве контекста
		СписокСвойств = Новый Соответствие;
	КонецЕсли;
	Для Каждого Свойство Из ЗначениеСвойства Цикл
		ПроверитьСвойствоПоСхеме(Свойство, СписокСвойств, ОписаниеДополнительныхСвойств);
	КонецЦикла;
КонецПроцедуры

Процедура ПроверитьНаличиеОбязательныхСвойств(ПроверяемыйОбъект, ПроверяемаяСхема)
	МассивОбязательныхПараметров = ПроверяемаяСхема.Получить("required");
	Если МассивОбязательныхПараметров = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого ИмяОбязательногоСвойства Из МассивОбязательныхПараметров Цикл
		ПроверитьНаличиеОбязательногоСвойстваПоИмени(ПроверяемыйОбъект, ИмяОбязательногоСвойства);
	КонецЦикла;
КонецПроцедуры

Процедура ПроверитьНаличиеОбязательногоСвойстваПоИмени(ПроверяемыйОбъект, ИмяОбязательногоСвойства)
    СвойствоНайдено = Ложь;
	Если ТипЗнч(ПроверяемыйОбъект) = Тип("Структура") Тогда
		СвойствоНайдено = ПроверяемыйОбъект.Свойство(ИмяОбязательногоСвойства);
	Иначе
		СвойствоНайдено = Не ПроверяемыйОбъект.Получить(ИмяОбязательногоСвойства) = Неопределено;
	КонецЕсли;
	Если СвойствоНайдено Тогда
		Возврат;
	КонецЕсли;
	
	ТекстОшибки = СтрШаблон("%1 Отсутствует обязательное свойство <%2>;",
								ШаблонБазовойОшибки,
								ИмяОбязательногоСвойства);
	Ошибки.Добавить(ТекстОшибки);
КонецПроцедуры

Процедура ПроверитьКоличествоСвойств(ЗначениеСвойства, ПроверяемаяСхема)
	КоличествоСвойств = ЗначениеСвойства.Количество();
	МинимумСвойств = ПроверяемаяСхема.Получить("minProperties");
	Если Не МинимумСвойств = Неопределено И КоличествоСвойств < МинимумСвойств Тогда
		ТекстДеталей = СтрШаблон("Количество свойств объекта <%1> меньше минимального порога <%2>",
									КоличествоСвойств,
									МинимумСвойств);
		ТекстОшибки = СтрШаблон("%1 %2", ШаблонБазовойОшибки, ТекстДеталей);
		Ошибки.Добавить(ТекстОшибки);
		Возврат;
	КонецЕсли;
	
	МаксимумСвойств = ПроверяемаяСхема.Получить("maxProperties");
	Если Не МаксимумСвойств = Неопределено И КоличествоСвойств > МаксимумСвойств Тогда
		ТекстДеталей = СтрШаблон("Количество свойств объекта <%1> больше максимального порога <%2>",
									КоличествоСвойств,
									МаксимумСвойств);
		ТекстОшибки = СтрШаблон("%1 %2", ШаблонБазовойОшибки, ТекстДеталей);
		Ошибки.Добавить(ТекстОшибки);
		Возврат;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

Процедура ВалидироватьБулево(Данные, ПроверяемаяСхема)  // BSLLS:Typo-off
	ОписаниеТипа = Новый ОписаниеТипов("Булево");
	ЗначениеСвойства = Данные.Значение;
	
	ТипЗначенияСоответствуетОписанию(ЗначениеСвойства, ОписаниеТипа);
КонецПроцедуры

Процедура УстановитьШаблонБазовойОшибки(Имя, Описание)
	Представление = СтрШаблон("<%1>",Имя);
	
	Если ЗначениеЗаполнено(Описание) Тогда
		Представление = СтрШаблон("<%1>(%2)", Имя, Описание);
	КонецЕсли;
	
	ШаблонБазовойОшибки = СтрШаблон("Ошибка валидации %1.", Представление);
КонецПроцедуры

Функция ТипЗначенияСоответствуетОписанию(ЗначениеСвойства, ОписаниеТипа)

	ПриведенноеЗначениеСвойства = ОписаниеТипа.ПривестиЗначение(ЗначениеСвойства);
	
	ОжидаемыйТип = ТипЗнч(ПриведенноеЗначениеСвойства);
	ФактическийТип = ТипЗнч(ЗначениеСвойства);
	
	РазличаютсяТипы = ОжидаемыйТип <> ФактическийТип;
	
	Если РазличаютсяТипы Тогда
		ПредставлениеОжидаемыхТипов = СтрСоединить(ОписаниеТипа.Типы(), "; ");
		ТекстОшибки =
			СтрШаблон("%1  Передан тип <%2>. Список допустимых типов: <%3>",
						ШаблонБазовойОшибки,
						ФактическийТип,
						ПредставлениеОжидаемыхТипов);
		Ошибки.Добавить(ТекстОшибки);
		Возврат Ложь;
	КонецЕсли;
	
	Если ПриведенноеЗначениеСвойства = ЗначениеСвойства Тогда
		// после приведения все совпадает. А значит тип подходит под схему.
		Возврат Истина;
	КонецЕсли;
		
	// Если мы здесь, значит отличаются Квалификаторы
	Если ФактическийТип = Тип("Дата") Тогда
		ИнкрементКвалификатора = СтрШаблон("Некорректный формат даты. Ожидается <%1>",
								ОписаниеТипа.КвалификаторыДаты.ЧастиДаты);
	ИначеЕсли ФактическийТип = Тип("Строка") Тогда
		ИнкрементКвалификатора = СтрШаблон("Длина строки превышает максимальную. Максимальная длина <%1>",
								ОписаниеТипа.КвалификаторыСтроки.Длина);
	ИначеЕсли ФактическийТип = Тип("Число") Тогда
		ИнкрементКвалификатора = "Некорректный формат значения, число должно быть целым.";
	Иначе
		//Тут мы никогда не окажемся.
		ВызватьИсключение "При обработке схемы возникла исключительная ситуация!";
	КонецЕсли;
	
	ТекстОшибки =
			СтрШаблон("%1  %2",
						ШаблонБазовойОшибки,
						ИнкрементКвалификатора);
	Ошибки.Добавить(ТекстОшибки);
	Возврат Ложь;
КонецФункции

// Возвращает копию исходного массива с уникальными значениями.
//
// Параметры:
//  Массив - Массив - массив произвольных значений.
//
// Возвращаемое значение:
//  Массив - массив уникальных элементов.
//
Функция СвернутьМассив(Знач Массив)
	Результат = Новый Массив;
	ДополнитьМассив(Результат, Массив, Истина);
	Возврат Результат;
КонецФункции

// Дополняет массив МассивПриемник значениями из массива МассивИсточник.
//
// Параметры:
//  МассивПриемник - Массив - массив, в который необходимо добавить значения.
//  МассивИсточник - Массив - массив значений для заполнения.
//  ТолькоУникальныеЗначения - Булево - если истина, то в массив будут включены только уникальные значения.
//
Процедура ДополнитьМассив(МассивПриемник, МассивИсточник, ТолькоУникальныеЗначения = Ложь)
	
	Если ТолькоУникальныеЗначения Тогда
		
		УникальныеЗначения = Новый Соответствие;
		
		Для Каждого Значение Из МассивПриемник Цикл
			УникальныеЗначения.Вставить(Значение, Истина);
		КонецЦикла;
		
		Для Каждого Значение Из МассивИсточник Цикл
			Если УникальныеЗначения[Значение] = Неопределено Тогда
				МассивПриемник.Добавить(Значение);
				УникальныеЗначения.Вставить(Значение, Истина);
			КонецЕсли;
		КонецЦикла;
		
	Иначе
		
		Для Каждого Значение Из МассивИсточник Цикл
			МассивПриемник.Добавить(Значение);
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

Функция ПолучитьПроверяемуюСхему(ИмяСхемы, ТекущийКонтекст)
	ПроверяемаяСхема = ТекущийКонтекст.Получить(ИмяСхемы);
	
	Если ПроверяемаяСхема = Неопределено Тогда
		// Если у нас на вход неопределено, значит такая схема не найдена. 
		// Это нормально, в случае если это неизвестное свойство. просто больше ничего не делаем
		Возврат ПроверяемаяСхема;
	КонецЕсли;
	
	ПроверяемаяСхема = РазыменоватьСхему(ПроверяемаяСхема);
	
	Возврат ПроверяемаяСхема;
КонецФункции

// Функция - Разыменовать схему
// Обрабатывает переданную схему.
// Получает необходимую схему по ссылке, если это требуется.
// Параметры:
//  ПроверяемаяСхема - Соответствие - Схема которую требуется разыменовать
//
// Возвращаемое значение:
// Соответствие  - Разыменованое соответствие
//
Функция РазыменоватьСхему(ПроверяемаяСхема) Экспорт
	РазыменованнаяСхема = ПроверяемаяСхема;
	Если РазыменованнаяСхема = Неопределено Тогда
		// Если у нас на вход неопределено, значит такая схема не найдена. 
		// Это нормально, в случае если это неизвестное свойство. просто больше ничего не делаем
		Возврат РазыменованнаяСхема;
	КонецЕсли;
	
	СсылкаНаСхему = РазыменованнаяСхема.Получить("$ref");
	
	Если ЗначениеЗаполнено(СсылкаНаСхему) Тогда
		РазыменованнаяСхема = ВалидаторПакетовПовтИсп.СхемаПоСтроковомуПути(СсылкаНаСхему, Спецификация);
	КонецЕсли;
	
	Возврат РазыменованнаяСхема;
КонецФункции

// Функция - Это сложная схема
//
// Параметры:
//  ПроверяемаяСхема - Соответствие	- Описание проверяемой схемы 
// 
// Возвращаемое значение:
//  Булево - Истина, если схема использует сложные конструкции
//
Функция ЭтоСложнаяСхема(ПроверяемаяСхема) Экспорт
	ЭтоOneOf = ЕстьСвойство("oneOf", ПроверяемаяСхема);
	ЭтоAllOf = ЕстьСвойство("allOf", ПроверяемаяСхема);
	ЭтоAnyOf = ЕстьСвойство("anyOf", ПроверяемаяСхема);
	
	Возврат ЭтоOneOf Или ЭтоAllOf Или ЭтоAnyOf;
КонецФункции

Функция ЕстьСвойство(ИмяСвойства, ПроверяемаяСхема)
	Возврат Не ПроверяемаяСхема.Получить(ИмяСвойства) = Неопределено;
КонецФункции

#КонецОбласти

