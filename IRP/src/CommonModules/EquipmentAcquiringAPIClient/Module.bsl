// @strict-types

#Region Public

// Get payment settings story.
// 
// Parameters:
//  PaymentInfo - String - Payment info
// 
// Returns:
//  Array of See PayByPaymentCardSettings, Array of See ReturnPaymentByPaymentCardSettings,
Function GetPaymentSettingsStory(PaymentInfo) Export
	PaymentSettingsArray = New Array;
	If Not IsBlankString(PaymentInfo) Then
		PaymentSettingsArray = CommonFunctionsServer.DeserializeJSON(PaymentInfo); // Array of See PayByPaymentCardSettings
	EndIf;
	Return PaymentSettingsArray;
EndFunction

#EndRegion

#Region API

// Terminal parameters.
// 
// Parameters:
//  Hardware - CatalogRef.Hardware - Hardware
//  Settings - See TerminalParametersSettings
// 
// Returns:
//  Boolean - Возвращает параметры работы терминала
Function TerminalParameters(Hardware, Settings) Export
	
EndFunction

// Pay by payment card.
// 
// Parameters:
//  Hardware - CatalogRef.Hardware - Hardware
//  Settings - See PayByPaymentCardSettings
// 
// Returns:
//  Boolean - Метод осуществляет авторизацию оплаты по карте
Async Function PayByPaymentCard(Hardware, Settings) Export
	Result = False;
	LockData = Settings.Form;
	Settings.Delete("Form");
	LockForm(LockData, True);
	Try
		Connections = Await HardwareClient.ConnectHardware(Hardware); // See HardwareClient.ConnectHardware
		ConnectParameters = Connections.ConnectParameters; // See HardwareClient.GetDriverObject
		If ConnectParameters.WriteLog Then
			HardwareServer.WriteLog(Hardware, "PayByPaymentCard", True, Settings);
		EndIf;
		If Connections.ConnectParameters.OldRevision Then
			// @skip-check dynamic-access-method-not-found
			Result = ConnectParameters.DriverObject.PayByPaymentCard(
				ConnectParameters.ID,
				Settings.InOut.CardNumber,
				Settings.In.Amount,
				Settings.InOut.ReceiptNumber,
				Settings.Out.RRNCode,
				Settings.Out.AuthorizationCode,
				Settings.Out.Slip
			); // Boolean
		Else
			// @skip-check dynamic-access-method-not-found
			Result = ConnectParameters.DriverObject.PayByPaymentCard(
				ConnectParameters.ID,
				Settings.In.MerchantNumber,
				Settings.In.Amount,
				Settings.InOut.CardNumber,
				Settings.InOut.ReceiptNumber,
				Settings.Out.RRNCode,
				Settings.Out.AuthorizationCode,
				Settings.Out.Slip
			); // Boolean
		EndIf;
		If ConnectParameters.WriteLog Then
			HardwareServer.WriteLog(Hardware, "PayByPaymentCard", False, Settings, Result);
		EndIf;		
		Connections = Await HardwareClient.DisconnectHardware(Hardware);
		
	Except
		Error = ErrorInfo();
		CommonFunctionsClientServer.ShowUsersMessage(ErrorProcessing.DetailErrorDescription(Error));
	EndTry;
	LockForm(LockData, False);
	
	Return Result;
EndFunction

// Return payment by payment card.
// 
// Parameters:
//  Hardware - CatalogRef.Hardware - Hardware
//  Settings - See ReturnPaymentByPaymentCardSettings
// 
// Returns:
//  Boolean - Метод осуществляет возврат платежа по карте
Async Function ReturnPaymentByPaymentCard(Hardware, Settings) Export
	Result = False;
	LockData = Settings.Form;
	Settings.Delete("Form");
	LockForm(LockData, True);
	Try
		Connections = Await HardwareClient.ConnectHardware(Hardware); // See HardwareClient.ConnectHardware
		ConnectParameters = Connections.ConnectParameters; // See HardwareClient.GetDriverObject
		If ConnectParameters.WriteLog Then
			HardwareServer.WriteLog(Hardware, "ReturnPaymentByPaymentCard", True, Settings);
		EndIf;
		If Connections.ConnectParameters.OldRevision Then
			//@skip-check dynamic-access-method-not-found
			Result = ConnectParameters.DriverObject.ReturnPaymentByPaymentCard(
				ConnectParameters.ID,
				Settings.InOut.CardNumber,
				Settings.In.Amount,
				Settings.InOut.ReceiptNumber,
				Settings.InOut.RRNCode,
				Settings.In.AuthorizationCode,
				Settings.Out.Slip
			); // Boolean
		Else
			//@skip-check dynamic-access-method-not-found
			Result = ConnectParameters.DriverObject.ReturnPaymentByPaymentCard(
				ConnectParameters.ID,
				Settings.In.MerchantNumber,
				Settings.In.Amount,
				Settings.InOut.CardNumber,
				Settings.InOut.ReceiptNumber,
				Settings.InOut.RRNCode,
				Settings.In.AuthorizationCode,
				Settings.Out.Slip
			); // Boolean
		EndIf;
		If ConnectParameters.WriteLog Then
			HardwareServer.WriteLog(Hardware, "ReturnPaymentByPaymentCard", False, Settings, Result);
		EndIf;
		Connections = Await HardwareClient.DisconnectHardware(Hardware);
	Except
		Error = ErrorInfo();
		CommonFunctionsClientServer.ShowUsersMessage(ErrorProcessing.DetailErrorDescription(Error));
	EndTry;
	
	LockForm(LockData, False);
	Return Result;
EndFunction

// Cancel payment by payment card.
// 
// Parameters:
//  Hardware - CatalogRef.Hardware - Hardware
//  Settings - See CancelPaymentByPaymentCardSettings
// 
// Returns:
//  Boolean - Метод осуществляет отмену платежа по карте
Async Function CancelPaymentByPaymentCard(Hardware, Settings) Export
	Connections = Await HardwareClient.ConnectHardware(Hardware); // See HardwareClient.ConnectHardware
	ConnectParameters = Connections.ConnectParameters; // See HardwareClient.GetDriverObject
	If ConnectParameters.WriteLog Then
		HardwareServer.WriteLog(Hardware, "CancelPaymentByPaymentCard", True, Settings);
	EndIf;
	If Connections.ConnectParameters.OldRevision Then
		//@skip-check dynamic-access-method-not-found
		Result = ConnectParameters.DriverObject.CancelPaymentByPaymentCard(
			ConnectParameters.ID,
			Settings.InOut.CardNumber,
			Settings.In.Amount,
			Settings.InOut.ReceiptNumber,
			Settings.In.RRNCode,
			Settings.In.AuthorizationCode,
			Settings.Out.Slip
		); // Boolean
	Else
		//@skip-check dynamic-access-method-not-found
		Result = ConnectParameters.DriverObject.CancelPaymentByPaymentCard(
			ConnectParameters.ID,
			Settings.In.MerchantNumber,
			Settings.In.Amount,
			Settings.InOut.CardNumber,
			Settings.InOut.ReceiptNumber,
			Settings.In.RRNCode,
			Settings.In.AuthorizationCode,
			Settings.Out.Slip
		); // Boolean
	EndIf;
	If ConnectParameters.WriteLog Then
		HardwareServer.WriteLog(Hardware, "CancelPaymentByPaymentCard", False, Settings, Result);
	EndIf;
	Connections = Await HardwareClient.DisconnectHardware(Hardware);
	Return Result;
EndFunction

// Emergency reversal.
// 
// Parameters:
//  Hardware - CatalogRef.Hardware - Hardware
//  Settings - See EmergencyReversalSettings
// 
// Returns:
//  Boolean - Метод отменяет последнюю транзакцию
Async Function EmergencyReversal(Hardware, Settings) Export
	Connections = Await HardwareClient.ConnectHardware(Hardware); // See HardwareClient.ConnectHardware
	ConnectParameters = Connections.ConnectParameters; // See HardwareClient.GetDriverObject
	If ConnectParameters.WriteLog Then
		HardwareServer.WriteLog(Hardware, "EmergencyReversal", True, Settings);
	EndIf;
	//@skip-check dynamic-access-method-not-found
	Result = ConnectParameters.DriverObject.EmergencyReversal(
		ConnectParameters.ID,
	); // Boolean
	If ConnectParameters.WriteLog Then
		HardwareServer.WriteLog(Hardware, "EmergencyReversal", False, Settings, Result);
	EndIf;	
	Connections = Await HardwareClient.DisconnectHardware(Hardware);
	Return Result;
EndFunction

// Settlement.
// 
// Parameters:
//  Hardware - CatalogRef.Hardware - Hardware
//  Settings - See SettlementSettings
// 
// Returns:
//  Boolean - Производится сверка итогов дня
Async Function Settlement(Hardware, Settings) Export
	Connections = Await HardwareClient.ConnectHardware(Hardware); // See HardwareClient.ConnectHardware
	ConnectParameters = Connections.ConnectParameters; // See HardwareClient.GetDriverObject
	If ConnectParameters.WriteLog Then
		HardwareServer.WriteLog(Hardware, "Settlement", True, Settings);
	EndIf;
	//@skip-check dynamic-access-method-not-found
	Result = ConnectParameters.DriverObject.Settlement(
		ConnectParameters.ID,
		Settings.Out.Slip
	); // Boolean
	If ConnectParameters.WriteLog Then
		HardwareServer.WriteLog(Hardware, "Settlement", False, Settings, Result);
	EndIf;		
	Connections = Await HardwareClient.DisconnectHardware(Hardware);
	Return Result;
EndFunction

#EndRegion

#Region Settings

// Terminal parameters settings.
// 
// Returns:
//  Structure - Terminal parameters settings:
// * Info - Structure:
// ** Name - String - Settings name
// * In - Structure:
// ** DeviceID - String - Идентификатор устройства
// * Out - Structure:
// ** PrintSlipOnTerminal - Boolean - Будет ли терминал самостоятельно печатать квитанции на своем принтере для операций.
// ** ShortSlip - Boolean - Терминал возвращает короткие слип-чеки, которые будут выводиться в теле фискального чека.
// ** CashWithdrawal - Boolean - Терминал поддерживает функцию выдачи наличных денежных средств.
// ** ElectronicCertificates - Boolean - Терминал поддерживает оплату электронными сертификатами ФЭС НСПК
Function TerminalParametersSettings() Export
	Str = New Structure;
	Str.Insert("Info", New Structure);
	Str.Info.Insert("Name", "TerminalParametersSettings");
	
	Str.Insert("In", New Structure);
	Str.In.Insert("DeviceID", "");
	
	Str.Insert("Out", New Structure);
	Str.Out.Insert("PrintSlipOnTerminal", False);
	Str.Out.Insert("ShortSlip", False);
	Str.Out.Insert("CashWithdrawal", False);
	Str.Out.Insert("ElectronicCertificates", False);
	
	Return Str;
EndFunction

// Pay by payment card settings.
// 
// Returns:
//  Structure - Pay by payment card settings:
// * Info - Structure:
// ** Name - String - Settings name
// * Form - Structure - Lock and unlock form elements:
// ** ElementToLock - ClientApplicationForm - Element or form. Will be locked until payment end
// ** ElementToHideAndShow - FormDecoration, FormGroup - Element or form. Will be showed until payment end
// * In - Structure:
// ** DeviceID - String - Идентификатор устройства
// ** MerchantNumber - Number - Номер мерчанта, доступного для данного эквайрингового терминала.
// ** Amount - Number - Сумма операции по карте
// * InOut - Structure:
// ** CardNumber - String - Номер Карты / Данные карты / Маскированный номер карты
// ** ReceiptNumber - String - Номер чека 
// * Out - Structure:
// ** RRNCode - String - Уникальный код транзакции RRN 
// ** AuthorizationCode - String - Код авторизации транзакции
// ** Slip - String - Текст квитанции по операции сформированный эквайринговым ПО. В случае отказа по операции возвращается текст квитанции отказа.
Function PayByPaymentCardSettings() Export
	Str = New Structure;
	
	Str.Insert("Info", New Structure);
	Str.Info.Insert("Name", "PayByPaymentCardSettings");
	
	Str.Insert("Form", New Structure);
	Str.Form.Insert("ElementToLock", Undefined);
	Str.Form.Insert("ElementToHideAndShow", Undefined);
	
	Str.Insert("In", New Structure);
	Str.In.Insert("DeviceID", "");
	Str.In.Insert("MerchantNumber", 0);
	Str.In.Insert("Amount", 0);
	
	Str.Insert("InOut", New Structure);
	Str.InOut.Insert("CardNumber", "");
	Str.InOut.Insert("ReceiptNumber", "");
	
	Str.Insert("Out", New Structure);
	Str.Out.Insert("RRNCode", "");
	Str.Out.Insert("AuthorizationCode", "");
	Str.Out.Insert("Slip", "");
	
	Return Str;
EndFunction

// Return payment by payment card settings.
// 
// Returns:
//  Structure - Return payment by payment card settings:
// * Info - Structure:
// ** Name - String - Settings name
// * Form - Structure - Lock and unlock form elements:
// ** ElementToLock - ClientApplicationForm - Element or form. Will be locked until payment end
// ** ElementToHideAndShow - FormDecoration, FormGroup - Element or form. Will be showed until payment end
// * In - Structure:
// ** DeviceID - String - Идентификатор устройства
// ** MerchantNumber - Number - Номер мерчанта, доступного для данного эквайрингового терминала.
// ** Amount - Number - Сумма операции по карте
// ** AuthorizationCode - String - Код авторизации транзакции
// * InOut - Structure:
// ** CardNumber - String - Номер Карты / Данные карты / Маскированный номер карты
// ** ReceiptNumber - String - Номер чека 
// ** RRNCode - String - Уникальный код транзакции RRN 
// * Out - Structure:
// ** Slip - String - Текст квитанции по операции сформированный эквайринговым ПО. В случае отказа по операции возвращается текст квитанции отказа.
Function ReturnPaymentByPaymentCardSettings() Export
	Str = New Structure;
		
	Str.Insert("Info", New Structure);
	Str.Info.Insert("Name", "ReturnPaymentByPaymentCardSettings");
	
	Str.Insert("Form", New Structure);
	Str.Form.Insert("ElementToLock", Undefined);
	Str.Form.Insert("ElementToHideAndShow", Undefined);
	
	Str.Insert("In", New Structure);
	Str.In.Insert("DeviceID", "");
	Str.In.Insert("MerchantNumber", Undefined);
	Str.In.Insert("Amount", Undefined);
	Str.In.Insert("AuthorizationCode", "");
	
	Str.Insert("InOut", New Structure);
	Str.InOut.Insert("CardNumber", Undefined);
	Str.InOut.Insert("ReceiptNumber", Undefined);
	Str.InOut.Insert("RRNCode", "");
	
	Str.Insert("Out", New Structure);
	
	Str.Out.Insert("Slip", "");
	
	Return Str;
EndFunction

// Cancel payment by payment card settings.
// 
// Returns:
//  Structure - Pay by payment card settings:
// * Info - Structure:
// ** Name - String - Settings name
// * In - Structure:
// ** DeviceID - String - Идентификатор устройства
// ** MerchantNumber - Number - Номер мерчанта, доступного для данного эквайрингового терминала.
// ** Amount - Number - Сумма операции по карте
// ** RRNCode - String - Уникальный код транзакции RRN 
// ** AuthorizationCode - String - Код авторизации транзакции
// * InOut - Structure:
// ** CardNumber - String - Номер Карты / Данные карты / Маскированный номер карты
// ** ReceiptNumber - String - Номер чека 
// * Out - Structure:
// ** Slip - String - Текст квитанции по операции сформированный эквайринговым ПО. В случае отказа по операции возвращается текст квитанции отказа.
Function CancelPaymentByPaymentCardSettings() Export
	Str = New Structure;
	
	Str.Insert("Info", New Structure);
	Str.Info.Insert("Name", "CancelPaymentByPaymentCardSettings");
	
	Str.Insert("In", New Structure);
	Str.In.Insert("DeviceID", "");
	Str.In.Insert("MerchantNumber", Undefined);
	Str.In.Insert("Amount", Undefined);
	Str.In.Insert("AuthorizationCode", "");
	Str.In.Insert("RRNCode", "");
	
	Str.Insert("InOut", New Structure);
	Str.InOut.Insert("CardNumber", Undefined);
	Str.InOut.Insert("ReceiptNumber", Undefined);
	
	Str.Insert("Out", New Structure);
	Str.Out.Insert("Slip", "");
	
	Return Str;
EndFunction

// Emergency reversal settings.
// 
// Returns:
//  Structure - Emergency reversal settings:
// * Info - Structure:
// ** Name - String - Settings name
// * In - Structure:
// ** DeviceID - String - Идентификатор устройства
Function EmergencyReversalSettings() Export
	Str = New Structure;
	
	Str.Insert("Info", New Structure);
	Str.Info.Insert("Name", "EmergencyReversalSettings");
	
	Str.Insert("In", New Structure);
	Str.In.Insert("DeviceID", "");
	
	Return Str;
EndFunction

// Settlement settings.
// 
// Returns:
//  Structure - Settlement settings:
// * Info - Structure:
// ** Name - String - Settings name
// * In - Structure:
// ** DeviceID - String - Идентификатор устройства
// * Out - Structure:
// ** Slip - String - Текст квитанции, сформированный Эквайринговым ПО
Function SettlementSettings() Export
	Str = New Structure;
	
	Str.Insert("Info", New Structure);
	Str.Info.Insert("Name", "SettlementSettings");
	
	Str.Insert("In", New Structure);
	Str.In.Insert("DeviceID", "");
	
	Str.Insert("Out", New Structure);
	Str.Out.Insert("Slip", "");
	
	Return Str;
EndFunction

#EndRegion

#Region PaymentForm

// Open payment form settings.
// 
// Returns:
//  Structure - Open payment form settings:
// * Amount - Number -
// * isReturn - Boolean -
// * RRNCode - String -
// * Hardware - CatalogRef.Hardware -
// * Interactive - Boolean - If false and Amount > 0 then on form open start payment
Function OpenPaymentFormSettings() Export
	Str = New Structure;
	Str.Insert("Amount", 0);
	Str.Insert("isReturn", False);
	Str.Insert("RRNCode", "");
	Str.Insert("Hardware", PredefinedValue("Catalog.Hardware.EmptyRef"));
	Str.Insert("Interactive", False);
	Return Str;
EndFunction

#EndRegion

#Region Service

Procedure LockForm(Settings, Lock)
	If Not Settings.ElementToLock = Undefined Then
		Settings.ElementToLock.ReadOnly = Lock;
	EndIf;
	
	If Not Settings.ElementToHideAndShow = Undefined Then
		Settings.ElementToHideAndShow.Visible = Lock;
	EndIf;
EndProcedure

#EndRegion
