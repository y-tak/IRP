#Region FORM

Procedure OnOpen(Object, Form, Cancel, MainTables) Export
	ViewClient_V2.OnOpen(Object, Form, "");
EndProcedure

#EndRegion

#Region COMPANY

Procedure CompanyOnChange(Object, Form, Item, MainTables) Export
	ViewClient_V2.CompanyOnChange(Object, Form, "");
EndProcedure

Procedure CompanyStartChoice(Object, Form, Item, ChoiceData, StandardProcessing) Export
	OpenSettings = DocumentsClient.GetOpenSettingsStructure();

	OpenSettings.ArrayOfFilters = New Array();
	OpenSettings.ArrayOfFilters.Add(DocumentsClientServer.CreateFilterItem("DeletionMark", True,
		DataCompositionComparisonType.NotEqual));
	OpenSettings.ArrayOfFilters.Add(DocumentsClientServer.CreateFilterItem("OurCompany", True,
		DataCompositionComparisonType.Equal));
	OpenSettings.FillingData = New Structure("OurCompany", True);

	DocumentsClient.CompanyStartChoice(Object, Form, Item, ChoiceData, StandardProcessing, OpenSettings);
EndProcedure

Procedure CompanyEditTextChange(Object, Form, Item, Text, StandardProcessing) Export
	ArrayOfFilters = New Array();
	ArrayOfFilters.Add(DocumentsClientServer.CreateFilterItem("DeletionMark", True, ComparisonType.NotEqual));
	ArrayOfFilters.Add(DocumentsClientServer.CreateFilterItem("OurCompany", True, ComparisonType.Equal));
	DocumentsClient.CompanyEditTextChange(Object, Form, Item, Text, StandardProcessing, ArrayOfFilters);
EndProcedure

#EndRegion

#Region _DATE

Procedure DateOnChange(Object, Form, Item) Export
	DocumentsClientServer.ChangeTitleGroupTitle(Object, Form);
EndProcedure

#EndRegion

#Region INVENTORY

Procedure InventoryBeforeAddRow(Object, Form, Item, Cancel, Clone, Parent, IsFolder, Parameter) Export
	ViewClient_V2.InventoryBeforeAddRow(Object, Form, Cancel, Clone);
EndProcedure

Procedure InventoryAfterDeleteRow(Object, Form, Item) Export
	ViewClient_V2.InventoryAfterDeleteRow(Object, Form);
EndProcedure

#Region INVENTORY_COLUMNS

#Region _ITEM

Procedure InventoryItemOnChange(Object, Form, Item, CurrentData = Undefined) Export
	ViewClient_V2.InventoryItemOnChange(Object, Form, CurrentData);
EndProcedure

Procedure InventoryItemStartChoice(Object, Form, Item, ChoiceData, StandardProcessing) Export
	DocumentsClient.ItemListItemStartChoice_IsNotServiceFilter(Object, Form, Item, ChoiceData, StandardProcessing);
EndProcedure

Procedure InventoryItemEditTextChange(Object, Form, Item, Text, StandardProcessing) Export
	DocumentsClient.ItemListItemEditTextChange_IsNotServiceFilter(Object, Form, Item, Text, StandardProcessing);
EndProcedure

#EndRegion

#Region ITEM_KEY

Procedure InventoryItemKeyOnChange(Object, Form, Item, CurrentData = Undefined) Export
	ViewClient_V2.InventoryItemKeyOnChange(Object, Form, CurrentData);
EndProcedure

#EndRegion

#Region QUANTITY

Procedure ItemListQuantityOnChange(Object, Form, CurrentData = Undefined) Export
	ViewClient_V2.InventoryQuantityOnChange(Object, Form, CurrentData);
EndProcedure

#EndRegion

#Region PRICE

Procedure ItemListPriceOnChange(Object, Form, CurrentData = Undefined) Export
	ViewClient_V2.InventorytPriceOnChange(Object, Form, CurrentData);
EndProcedure

#EndRegion

#Region AMOUNT

Procedure ItemListAmountOnChange(Object, Form, CurrentData = Undefined) Export
	ViewClient_V2.InventoryAmountOnChange(Object, Form, CurrentData);
EndProcedure

#EndRegion

#EndRegion

#EndRegion

#Region ACCOUNT_BALANCE

Procedure AccountBalanceBeforeAddRow(Object, Form, Item, Cancel, Clone, Parent, IsFolder, Parameter) Export
	ViewClient_V2.AccountBalanceBeforeAddRow(Object, Form, Cancel, Clone);
EndProcedure

Procedure AccountBalanceAfterDeleteRow(Object, Form, Item) Export
	ViewClient_V2.AccountBalanceAfterDeleteRow(Object, Form);
EndProcedure

#Region ACCOUNT_BALANCE_COLUMNS

#Region ACCOUNT

Procedure AccountBalanceAccountOnChange(Object, Form, Item, CurrentData = Undefined) Export
	ViewClient_V2.AccountBalanceAccountOnChange(Object, Form, CurrentData);
EndProcedure

#EndRegion

#EndRegion

#EndRegion

#Region CASH_IN_TRANSIT

&AtClient
Procedure CashInTransitBeforeAddRow(Object, Form, Item, Cancel, Clone, Parent, IsFolder, Parameter) Export
	ViewClient_V2.CashInTransitBeforeAddRow(Object, Form, Cancel, Clone);
EndProcedure

&AtClient
Procedure CashInTransitAfterDeleteRow(Object, Form, Item) Export
	ViewClient_V2.CashInTransitAfterDeleteRow(Object, Form);
EndProcedure

#Region CASH_IN_TRANSIT_COLUMNS

#Region RECEIPTING_ACCOUNT

&AtClient
Procedure CashInTransitReceiptingAccountOnChange(Object, Form, Item, CurrentData = Undefined) Export
	ViewClient_V2.CashInTransitReceiptingAccountOnChange(Object, Form, CurrentData);
EndProcedure

#EndRegion

#EndRegion

#EndRegion

#Region EMPLOYEE_CASH_ADVANCE

Procedure EmployeeCashAdvanceBeforeAddRow(Object, Form, Item, Cancel, Clone, Parent, IsFolder, Parameter) Export
	ViewClient_V2.EmployeeCashAdvanceBeforeAddRow(Object, Form, Cancel, Clone);
EndProcedure

Procedure EmployeeCashAdvanceAfterDeleteRow(Object, Form, Item) Export
	ViewClient_V2.EmployeeCashAdvanceAfterDeleteRow(Object, Form);
EndProcedure

#Region EMPLOYEE_CASH_ADVANCE_COLUMNS

#Region ACCOUNT

Procedure EmployeeCashAdvanceAccountOnChange(Object, Form, Item, CurrentData = Undefined) Export
	ViewClient_V2.EmployeeCashAdvanceAccountOnChange(Object, Form, CurrentData);
EndProcedure

#EndRegion

#EndRegion

#EndRegion

#Region ADVANCE_FROM_RETAIL_CUSTOMERS

Procedure AdvanceFromRetailCustomersBeforeAddRow(Object, Form, Item, Cancel, Clone, Parent, IsFolder, Parameter) Export
	ViewClient_V2.AdvanceFromRetailCustomersBeforeAddRow(Object, Form, Cancel, Clone);
EndProcedure

Procedure AdvanceFromRetailCustomersAfterDeleteRow(Object, Form, Item) Export
	ViewClient_V2.AdvanceFromRetailCustomersAfterDeleteRow(Object, Form);
EndProcedure

#EndRegion

#Region SALARY_PAYMENT

Procedure SalaryPaymentBeforeAddRow(Object, Form, Item, Cancel, Clone, Parent, IsFolder, Parameter) Export
	ViewClient_V2.SalaryPaymentBeforeAddRow(Object, Form, Cancel, Clone);
EndProcedure

Procedure SalaryPaymentAfterDeleteRow(Object, Form, Item) Export
	ViewClient_V2.SalaryPaymentAfterDeleteRow(Object, Form);
EndProcedure

#EndRegion




