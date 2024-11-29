﻿// BSLLS-off
// @strict-types

/////////////////////////////////////////////////////////////////////////////////
// Экспортные процедуры и функции, предназначенные для использования другими 
// объектами конфигурации или другими программами
///////////////////////////////////////////////////////////////////////////////// 
#Область СлужебныйПрограммныйИнтерфейс

Процедура ИсполняемыеСценарии() Экспорт
	
    ЮТТесты
		.ЗависитОт().ФайлыПроекта("tests/fixtures/schema.json")
		.ДобавитьТестовыйНабор("ОбщиеТесты")
			.ДобавитьТест("Ошбика_ОжиданиеОбъекта")
			.ДобавитьТест("Ошбика_ОжиданиеМассива")
			.ДобавитьТест("Ошибка_НекорректныйТип")
			.ДобавитьТест("Ошибка_НеЗаполненоОбязательноеСвойство")
		.ДобавитьТестовыйНабор("ВалидацияСтрок")
			.ДобавитьТест("Ошибка_СтрокаКорочеМинимальной")
			.ДобавитьТест("Ошибка_СтрокаДлиннееМаксимальной")
			.ДобавитьТест("Ошибка_СтрокаНеИзПеречисления")
			.ДобавитьТест("Ошибка_РазличныйКвалификаторДаты")
			.ДобавитьТест("Ошибка_НекорректныйФормат_Дата")
			.ДобавитьТест("Ошибка_НекорректныйФормат_ДатаВремя")
			.ДобавитьТест("Ошибка_НекорректныйФормат_Base64")
			.ДобавитьТест("Ошибка_НекорректныйФормат_РегулярноеВыражение")
				.СПараметрами("pattern")
				.СПараметрами("uri")
				.СПараметрами("email")
				.СПараметрами("uuid")
				.СПараметрами("ipv4")
				.СПараметрами("ipv6")
		.ДобавитьТестовыйНабор("ВалидацияЧисел")
			.ДобавитьТест("Ошибка_ЧислоМеньшеМинимума")
			.ДобавитьТест("Ошибка_ЧислоБольшеМаксимума")
			.ДобавитьТест("Ошибка_ЧислоМеньшеМинимума_неВключая")
			.ДобавитьТест("Ошибка_ЧислоБольшеМаксимума_неВключая")
			.ДобавитьТест("Ошибка_ЧислоКратноЗначению")
			.ДобавитьТест("Ошибка_ЧислоНеЦелое")
		.ДобавитьТестовыйНабор("Массивы")
			.ДобавитьТест("Ошибка_ЧислоЭлементовМеньшеМинимума")
			.ДобавитьТест("Ошибка_ЧислоЭлементовБольшеМаксимума")
			.ДобавитьТест("Ошибка_НеУникальныеЭлементы")
		.ДобавитьТестовыйНабор("Объекты")
			.ДобавитьТест("Ошибка_ЧислоСвойствМеньшеМинимума")
			.ДобавитьТест("Ошибка_ЧислоСвойствБольшеМаксимума")
			.ДобавитьТест("Ошибка_НетОбязательногоСвойства")
			.ДобавитьТест("Ошибка_ПроверкаРаботыЗапретаДопСвойств")
			.ДобавитьТест("ВалидацияДопСвойств")
				.СПараметрами("additional_true")
				.СПараметрами("additional_empty")
				.СПараметрами("additional_object", Истина)
				.СПараметрами("additional_ref", Истина)
        .ДобавитьТестовыйНабор("ПозитивныеТесты")
			.ДобавитьТест("РазрешениеСсылочногоТипа")
			.ДобавитьТест("УспешнаяВалидацияОбъекта")
			.ДобавитьТест("УспешнаяВалидацияМассива")
			.ДобавитьТест("УспешнаяВалидацияСтроки")
			.ДобавитьТест("УспешнаяВалидацияЧисла")
			.ДобавитьТест("УспешнаяВалидацияЦелогоЧисла")
			.ДобавитьТест("УспешнаяВалидацияБулева")
			.ДобавитьТест("УспешнаяВложенногоСложногоОбъекта")
			.ДобавитьТест("УспешнаяВалидацияAllOf")
			.ДобавитьТест("УспешнаяВалидацияOneOf")
			.ДобавитьТест("УспешнаяВалидацияAnyOf")
			.ДобавитьТест("УспешнаяВалидацияСложногоОбъекта")
			.ДобавитьТест("УспешнаяВалидацияNot")
			.ДобавитьТест("УспешнаяВалидацияEnum")
				.СПараметрами("string")
				.СПараметрами(1)
				.СПараметрами(1.1)
				.СПараметрами(true)
				.СПараметрами(NULL)
			.ДобавитьТест("УспешнаяВалидацияДискриминатор")
				.Представление("Дискриминатор_неявное_сопоставление")
				.СПараметрами(Новый Структура("type, valueA", "A", "hello world"))
				.Представление("Дискриминатор_явное_сопоставление")
				.СПараметрами(Новый Структура("type, valueA", "testA", "hello world"))
				.Представление("Дискриминатор_Комплексная_проверка")
				.СПараметрами(Новый Структура("type, valueA, valueB, valueC", "C", "hello world", 123, Истина))
				.Представление("Дискриминатор_Проверка_соответствия")
				.СПараметрами(СоздатьСоответствиеДляПроверкиДескриминатора())
		.ДобавитьТестовыйНабор("НегативныеТесты")
			.ДобавитьТест("Ошибка_ВалидацияОбъекта")
			.ДобавитьТест("Ошибка_ВалидацияМассива")
			.ДобавитьТест("Ошибка_ВалидацияСтроки")
			.ДобавитьТест("Ошибка_ВалидацияЧисла")
			.ДобавитьТест("Ошибка_ВалидацияЦелогоЧисла")
			.ДобавитьТест("Ошибка_ВалидацияБулева")
			.ДобавитьТест("Ошибка_ВалидацияNot")
		.ДобавитьТестовыйНабор("СложныеСхемы")
			.ДобавитьТест("Ошибка_allOf")
			.ДобавитьТест("Ошибка_oneOf")
			.ДобавитьТест("Ошибка_anyOf")
			.ДобавитьТест("Ошибка_ВалидацияСложногоОбъекта")
			.ДобавитьТест("Ошибка_ВалидацияПоДискриминатору")
				.Представление("Дискриминатор_нет_соответствий_в_схемах")
				.СПараметрами(Новый Структура("type, valueA, commonField", "A", 123, "hello world"), "Объект должен соответствовать хотя бы одной схеме")
				.Представление("Дискриминатор_не_указан")
				.СПараметрами(Новый Структура("typo, valueA", "A", "hello world"), "<discriminator> ключевое свойство <type> Должно существовать и быть заполнено;")
				.Представление("Дискриминатор_нет_схем_поДискриминатору")
                .СПараметрами(Новый Структура("typo, valueA", "Нет такого", "hello world"), "Объект должен соответствовать хотя бы одной схеме")
КонецПроцедуры

#Область События

Процедура ПередВсемиТестами() Экспорт
 	ПолноеИмяФайла = ЮТест.Зависимость(ЮТЗависимости.ФайлыПроекта("tests/fixtures/schema.json")).ПолноеИмя; // Получаем результат работы зависимости

    ЮТест.ОжидаетЧто(ЮТФайлы.Существует(ПолноеИмяФайла), "Схема не найдена!")
        .ЭтоИстина();
	ЮТест.КонтекстМодуля().Вставить("Схема", ЮТОбщий.ДанныеТекстовогоФайла(ПолноеИмяФайла));
КонецПроцедуры

Процедура ПередКаждымТестом() Экспорт
	
КонецПроцедуры

Процедура ПослеКаждогоТеста() Экспорт
	
КонецПроцедуры

Процедура ПослеВсехТестов() Экспорт
	
КонецПроцедуры

#КонецОбласти

Процедура Ошибка_НетОбязательногоСвойства() Экспорт
	ОбъектПроверки = Новый Структура("test", "hello world!");
	ИмяСхемы = "object";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Отсутствует обязательное свойство"))
	
КонецПроцедуры
		
Процедура Ошибка_НеЗаполненоОбязательноеСвойство() Экспорт
	ОбъектПроверки = Новый Структура("required");
	ИмяСхемы = "object";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("объявлено, и должно быть заполнено, но это не так"))
	
КонецПроцедуры
		
Процедура Ошбика_ОжиданиеОбъекта() Экспорт
	ОбъектПроверки = Новый Структура("nested_object", "Не объект");
	ИмяСхемы = "object";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Передан тип <.*>. Список допустимых типов: <.*Структура.*>"))
	
КонецПроцедуры

Процедура Ошбика_ОжиданиеМассива() Экспорт
	ОбъектПроверки = Новый Структура("nested_array", "Не Массив");
	ИмяСхемы = "object";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Передан тип <.*>. Список допустимых типов: <.*Массив.*>"))
	
КонецПроцедуры
		
Процедура Ошибка_НекорректныйТип() Экспорт
	ОбъектПроверки = "Привет";
	ИмяСхемы = "simple_number";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Передан тип <.*>. Список допустимых типов: <.*>"))
	
КонецПроцедуры

Процедура Ошибка_СтрокаКорочеМинимальной() Экспорт
	ОбъектПроверки = Новый Соответствие;
	ОбъектПроверки.Вставить("minmax", "");
	
	ИмяСхемы = "strings";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Длина, меньше требуемой."))
	
КонецПроцедуры
		
Процедура Ошибка_СтрокаДлиннееМаксимальной() Экспорт
	ОбъектПроверки = Новый Соответствие;
	ОбъектПроверки.Вставить("minmax", "1234567891011");
	
	ИмяСхемы = "strings";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Длина строки превышает максимальную. Максимальная длина <10>"))
	
КонецПроцедуры
		
Процедура Ошибка_СтрокаНеИзПеречисления() Экспорт
	ОбъектПроверки = Новый Соответствие;
	ОбъектПроверки.Вставить("enum", "Что-то не то");
	
	ИмяСхемы = "strings";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Значение <.*> не найдено среди доступных вариантов. Список доступных значений:"))
	
КонецПроцедуры
		
Процедура Ошибка_РазличныйКвалификаторДаты() Экспорт
	ОбъектПроверки = Новый Соответствие;
	ОбъектПроверки.Вставить("date", Дата("20241231010000"));
	
	ИмяСхемы = "strings";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Некорректный формат даты. Ожидается <.*>"))
	
КонецПроцедуры
		
Процедура Ошибка_НекорректныйФормат_Дата() Экспорт
	ОбъектПроверки = Новый Соответствие;
	ОбъектПроверки.Вставить("date", ЗаписатьДатуJSON(Дата("20241231010000"),ФорматДатыJSON.ISO));
	
	ИмяСхемы = "strings";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Неверный формат даты. Ожидается строка в формате <.*>"))
	
КонецПроцедуры
		
Процедура Ошибка_НекорректныйФормат_ДатаВремя() Экспорт
	ОбъектПроверки = Новый Соответствие;
	ОбъектПроверки.Вставить("date-time", "не дата и время");
	
	ИмяСхемы = "strings";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Неверный формат. Не удалось привести значение <.*>, к дате."))
	
КонецПроцедуры
		
Процедура Ошибка_НекорректныйФормат_Base64() Экспорт
	ОбъектПроверки = Новый Соответствие;
	ОбъектПроверки.Вставить("base64", "не base64");
	
	ИмяСхемы = "strings";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Ожидалось Base64 значение."))
	
КонецПроцедуры

Процедура Ошибка_НекорректныйФормат_РегулярноеВыражение(ИдентификаторФормата) Экспорт
	ОбъектПроверки = Новый Соответствие;
	ОбъектПроверки.Вставить(ИдентификаторФормата, "не корректное значение");
	
	ИмяСхемы = "strings";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Ожидался формат "+ИдентификаторФормата))
	
КонецПроцедуры

Процедура Ошибка_ЧислоМеньшеМинимума_неВключая() Экспорт
	ОбъектПроверки = Новый Соответствие;
	ОбъектПроверки.Вставить("exclusiveminmax", 0);
	
	ИмяСхемы = "numbers";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Значение <0> должно быть больше <1>"))
КонецПроцедуры

Процедура Ошибка_ЧислоБольшеМаксимума_неВключая() Экспорт
	ОбъектПроверки = Новый Соответствие;
	ОбъектПроверки.Вставить("exclusiveminmax", 100);
	
	ИмяСхемы = "numbers";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Значение <100> должно быть меньше <10>"))
КонецПроцедуры
		
Процедура Ошибка_ЧислоМеньшеМинимума() Экспорт
	ОбъектПроверки = Новый Соответствие;
	ОбъектПроверки.Вставить("minmax", 0);
	
	ИмяСхемы = "numbers";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Значение <0> должно быть больше или равно <1>"))
КонецПроцедуры

Процедура Ошибка_ЧислоБольшеМаксимума() Экспорт
	ОбъектПроверки = Новый Соответствие;
	ОбъектПроверки.Вставить("minmax", 100);
	
	ИмяСхемы = "numbers";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Значение <100> должно быть меньше или равно <10>"))
КонецПроцедуры

Процедура Ошибка_ЧислоКратноЗначению() Экспорт
	ОбъектПроверки = Новый Соответствие;
	ОбъектПроверки.Вставить("multipleOf", 15);
	
	ИмяСхемы = "numbers";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Значение <15> должно быть кратно <10>"))
КонецПроцедуры

Процедура Ошибка_ЧислоНеЦелое() Экспорт
	ОбъектПроверки = Новый Соответствие;
	ОбъектПроверки.Вставить("integer", 15.5);
	
	ИмяСхемы = "numbers";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Некорректный формат значения, число должно быть целым."))
	
КонецПроцедуры

Процедура Ошибка_ЧислоЭлементовМеньшеМинимума() Экспорт
	ОбъектПроверки = Новый Соответствие;
	ОбъектПроверки.Вставить("minmax", ЮТКоллекции.ЗначениеВМассиве("Раз"));
	
	ИмяСхемы = "arrays";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Количество элементов массива <1> меньше минимального порога <2>"))
		
КонецПроцедуры
		
Процедура Ошибка_ЧислоЭлементовБольшеМаксимума() Экспорт
	ОбъектПроверки = Новый Соответствие;
	ОбъектПроверки.Вставить("minmax", ЮТКоллекции.ЗначениеВМассиве("Раз", 2, 3, Ложь));
	
	ИмяСхемы = "arrays";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Количество элементов массива <4> больше максимального порога <3>"))
		
КонецПроцедуры

Процедура Ошибка_НеУникальныеЭлементы() Экспорт
	ОбъектПроверки = Новый Соответствие;
	ОбъектПроверки.Вставить("unique", ЮТКоллекции.ЗначениеВМассиве("Раз", 2, 2, Ложь));
	
	ИмяСхемы = "arrays";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Значения в массиве не уникальны;"))
		
КонецПроцедуры
		
Процедура Ошибка_ЧислоСвойствМеньшеМинимума() Экспорт
	ОбъектПроверки = Новый Соответствие;
	ОбъектПроверки.Вставить("minmax", Новый Структура("Раз"));
	
	ИмяСхемы = "objects";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Количество свойств объекта <1> меньше минимального порога <2>"))
		
КонецПроцедуры
		
Процедура Ошибка_ЧислоСвойствБольшеМаксимума() Экспорт
	ОбъектПроверки = Новый Соответствие;
	ОбъектПроверки.Вставить("minmax", Новый Структура("Раз, Два, Три, Четыре"));
	
	ИмяСхемы = "objects";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Количество свойств объекта <4> больше максимального порога <3>"))
		
КонецПроцедуры

Процедура Ошибка_ПроверкаРаботыЗапретаДопСвойств() Экспорт
	ОбъектПроверки = Новый Соответствие;
	ОбъектПроверки.Вставить("additional_false", Новый Структура("normal, additional", "Тут все ок", "Тут Ошибочка"));
	
	ИмяСхемы = "objects";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Не удалось найти свойство <additional> в схеме данных."))
		
КонецПроцедуры
		
Процедура ВалидацияДопСвойств(ИмяПроверяемойСхемы, ЖдемОшибку = Ложь) Экспорт
	ОбъектПроверки = Новый Соответствие;
	ОбъектПроверки.Вставить(ИмяПроверяемойСхемы, Новый Структура("normal, additional", "Тут все ок", 42));
	
	ИмяСхемы = "objects";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);

	Если ЖдемОшибку Тогда
		ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Передан тип <Число>. Список допустимых типов: <Строка>"));
	Иначе
		ЮТест.ОжидаетЧто(МассивОшибок)
			 .ИмеетДлину(0)
	КонецЕсли;
КонецПроцедуры

Процедура РазрешениеСсылочногоТипа() Экспорт
	ОбъектПроверки = Новый Структура("ref", 123);
	ИмяСхемы = "object";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
			// если все разрешится корректно, тип должен быть ограничен строкой. Потому возникнет проблема несоответствия типа
    		.СодержитСтрокуПоШаблону("Передан тип <.*>. Список допустимых типов: <.*>"))
	
КонецПроцедуры

Процедура УспешнаяВалидацияОбъекта() Экспорт
	ОбъектПроверки = Новый Структура("required", "Требуемое");
	ИмяСхемы = "object";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			 .ИмеетДлину(0)
КонецПроцедуры
		
Процедура УспешнаяВалидацияМассива() Экспорт
	ОбъектПроверки = ЮТКоллекции.ЗначениеВМассиве("Раз","Два", "Три");
	ИмяСхемы = "array";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			 .ИмеетДлину(0)
КонецПроцедуры

Процедура УспешнаяВалидацияСтроки() Экспорт
	ОбъектПроверки = "Привет, Мир!";
	ИмяСхемы = "simple_string";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			 .ИмеетДлину(0)
КонецПроцедуры

Процедура УспешнаяВалидацияЧисла() Экспорт
	ОбъектПроверки = 42.5;
	ИмяСхемы = "simple_number";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			 .ИмеетДлину(0)
КонецПроцедуры
		
Процедура УспешнаяВалидацияЦелогоЧисла() Экспорт
	ОбъектПроверки = 42;
	ИмяСхемы = "simple_integer";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			 .ИмеетДлину(0)
КонецПроцедуры

Процедура УспешнаяВалидацияБулева() Экспорт
	ОбъектПроверки = true;
	ИмяСхемы = "simple_boolean";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			 .ИмеетДлину(0)
КонецПроцедуры
		 
Процедура УспешнаяВложенногоСложногоОбъекта() Экспорт
	ОбъектПроверки = Новый Структура("required, nested_object", "Требуемое", Новый Структура("required", "Требуемое"));
	ИмяСхемы = "object";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			 .ИмеетДлину(0)
КонецПроцедуры

Процедура Ошибка_ВалидацияОбъекта() Экспорт
	ОбъектПроверки = ЮТКоллекции.ЗначениеВМассиве("Раз","Два", "Три");
	ИмяСхемы = "object";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Передан тип <.*>. Список допустимых типов: <.*Структура.*>"))
КонецПроцедуры
		
Процедура Ошибка_ВалидацияМассива() Экспорт
	ОбъектПроверки = "Никак не массив";
	ИмяСхемы = "array";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Передан тип <.*>. Список допустимых типов: <Массив>"))
КонецПроцедуры

Процедура Ошибка_ВалидацияСтроки() Экспорт
	ОбъектПроверки = ЮТКоллекции.ЗначениеВМассиве("Раз","Два", "Три");
	ИмяСхемы = "simple_string";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Передан тип <.*>. Список допустимых типов: <Строка>"))
КонецПроцедуры

Процедура Ошибка_ВалидацияЧисла() Экспорт
	ОбъектПроверки = "Не число";
	ИмяСхемы = "simple_number";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Передан тип <.*>. Список допустимых типов: <Число>"))

КонецПроцедуры
		
Процедура Ошибка_ВалидацияЦелогоЧисла() Экспорт
	ОбъектПроверки = "Не число";
	ИмяСхемы = "simple_integer";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Передан тип <.*>. Список допустимых типов: <Число>"))

КонецПроцедуры

Процедура Ошибка_ВалидацияБулева() Экспорт
	ОбъектПроверки = "Не булево";
	ИмяСхемы = "simple_boolean";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Передан тип <.*>. Список допустимых типов: <Булево>"))
КонецПроцедуры
		
Процедура Ошибка_oneOf() Экспорт
	ОбъектПроверки = Новый Структура("type, valueA, valueB", "A", "Example", 123);
	ИмяСхемы = "OneOf";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("<oneOf> Объект должен соответствовать только одной схеме. Индексы валидных схем <0;1>"))

КонецПроцедуры

Процедура УспешнаяВалидацияOneOf() Экспорт
	
	ИмяСхемы = "OneOf";
	ОбъектПроверки = Новый Структура("type, valueA", "A", "Example");
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлину(0);
			
	ОбъектПроверки = Новый Структура("type, valueB", "B", 123);
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлину(0)

КонецПроцедуры

Процедура Ошибка_anyOf() Экспорт
	ОбъектПроверки = Новый Структура("fieldC", true);
	ИмяСхемы = "AnyOf";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("<anyOf> Объект должен соответствовать хотя бы одной схеме."))

КонецПроцедуры

Процедура УспешнаяВалидацияAnyOf() Экспорт
	
	ИмяСхемы = "AnyOf";
	ОбъектПроверки = Новый Структура("fieldA", "Some text");
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлину(0);
			
	ОбъектПроверки = Новый Структура("fieldB", 42);
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлину(0);
			
	ОбъектПроверки = Новый Структура("fieldA, fieldB","Some text", 42);
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлину(0);
КонецПроцедуры
		
Процедура Ошибка_AllOf() Экспорт
	ОбъектПроверки = Новый Структура("commonField", "Some text");
	ИмяСхемы = "AllOf";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("<allOf> Объект должен соответствовать всем схемам."))
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Отсутствует обязательное свойство <additionalField>"))

КонецПроцедуры

Процедура УспешнаяВалидацияAllOf() Экспорт
	
	ИмяСхемы = "AllOf";
	ОбъектПроверки = Новый Структура("commonField, additionalField", "Some text", 42);
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлину(0);
КонецПроцедуры
		
Процедура УспешнаяВалидацияСложногоОбъекта() Экспорт
	
	ИмяСхемы = "ComplexValidation";
	ОбъектПроверки = Новый Структура("id, typeA, valueA, status", "101", "example", 42, "active");
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлину(0);
КонецПроцедуры

Процедура Ошибка_ВалидацияСложногоОбъекта() Экспорт
	ИмяСхемы = "ComplexValidation";
	ОбъектПроверки = Новый Структура("id, typeA, valueA", "101", "example", 42);
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("<allOf> Объект должен соответствовать всем схемам."))
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("Отсутствует обязательное свойство <status>"))

КонецПроцедуры

Процедура Ошибка_ВалидацияNot() Экспорт
	ИмяСхемы = "Not";
	ОбъектПроверки = "test";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону("<not> Объект не должен соответствовать схеме, а он соответствует;"))
КонецПроцедуры
		
Процедура УспешнаяВалидацияNot() Экспорт
	
	ИмяСхемы = "Not";
	ОбъектПроверки = "Не test";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлину(0);
КонецПроцедуры

Процедура УспешнаяВалидацияEnum(Значение) Экспорт
	
	ИмяСхемы = "different_types_enum";
	ОбъектПроверки = Значение;
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлину(0);
КонецПроцедуры

Процедура Ошибка_ВалидацияПоДискриминатору(ОбъектПроверки, Ошибка) Экспорт
	ИмяСхемы = "discriminator";

	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлинуБольше(0)
			.Содержит(ЮТест.Предикат() // Значение по условиям
    		.СодержитСтрокуПоШаблону(Ошибка))
КонецПроцедуры
		
Процедура УспешнаяВалидацияДискриминатор(ОбъектПроверки) Экспорт
	
	ИмяСхемы = "discriminator";
	МассивОшибок = Валидировать(ОбъектПроверки, ИмяСхемы);
	
	ЮТест.ОжидаетЧто(МассивОшибок)
			.ИмеетДлину(0);
КонецПроцедуры
#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция Валидировать(МодельДанных, ИмяСхемы)
	Возврат  ВалидаторПакетов.Валидировать(МодельДанных, ИмяСхемы, ЮТест.КонтекстМодуля().Схема);
КонецФункции

Функция СоздатьСоответствиеДляПроверкиДескриминатора()
	Соответствие = Новый Соответствие;
	
	Соответствие.Вставить("type", "A");
	Соответствие.Вставить("valueA", "hello world");
	Возврат Соответствие;
КонецФункции

#КонецОбласти
