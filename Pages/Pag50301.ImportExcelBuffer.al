page 50301 ImportExcelBuffer
{
    UsageCategory = Tasks;
    ApplicationArea = ALL;
    Caption = 'ImportExcelBuffer';
    PageType = Worksheet;
    SourceTable = "Excel Import Buffer ";
    AutoSplitKey = true;
    DelayedInsert = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    SaveValues = true;
    SourceTableView = sorting("Transaction Name", "Line No.");


    layout
    {
        area(content)
        {
            field(TransName1; TransName1)
            {
                ApplicationArea = All;
                Caption = 'TransName';
                ToolTip = 'Specifies the value of the TransName field.';
            }
            repeater(Group)
            {
                Editable = false;
                field("Transaction Name"; Rec."Transaction Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Name field.';
                    Caption = 'Transaction Name';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.';
                    Caption = 'Line No.';
                }
                field("Product No"; Rec."Product No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product No field.';
                    Caption = 'Product No';
                }
                field("Customer No"; Rec."Customer No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer No field.';
                    Caption = 'Customer No';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                    Caption = 'Date';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                    Caption = 'Type';
                }
                field("Payment Method"; Rec."Payment Method")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Method field.';
                    Caption = 'Payment Method';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                    Caption = 'Quantity';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Price field.';
                    Caption = 'Unit Price';
                }

                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                    Caption = 'File Name';
                    ToolTip = 'Specifies the value of the File Name field.';
                }
                field("Sheet Name"; Rec."Sheet Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sheet Name field.';
                    Caption = 'Sheet Name';
                }
                field("Imported Date"; Rec."Imported Date")
                {
                    ApplicationArea = All;
                    Caption = 'Imported Date';
                    ToolTip = 'Specifies the value of the Imported Date field.';
                }
                field("Impotred Time"; Rec."Impotred Time")
                {
                    ApplicationArea = All;
                    Caption = 'Impotred Time';
                    ToolTip = 'Specifies the value of the Impotred Time field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Excel Import")
            {
                ApplicationArea = All;
                Promoted = true;
                Image = ImportExcel;
                Caption = 'Import';
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Excel Imported action.';
                trigger OnAction()
                var
                begin
                    if TransName1 = '' then
                        Error(BatchIsBlankMsg);
                    ReadExcelSheet();
                    ImportExcelData();
                end;
            }
            action("Export Excel")
            {
                ApplicationArea = All;
                Promoted = true;
                Image = ExportToExcel;
                Caption = 'Export';
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Excel Exported action.';
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    ExportExcelBuffer(Rec);
                end;
            }
        }
    }
    var
        TransName1: Text[30];
        FileName: text[100];
        SheetName: Text[100];
        TempExcelBuffer: Record "Excel Buffer" temporary;
        uplodMsg: Label 'Please Choose The Excel file';
        NoFileMsg: Label 'No excel File Found';
        BatchIsBlankMsg: Label 'Transaction Name Is blank';
        ExcelImportSuccess: Label 'Excel File Imported Successfully';

    local procedure ReadExcelSheet()
    var
        FileManagement: Codeunit "File Management";
        Istream: InStream;
        FromFile: Text[100];
    begin
        UploadIntoStream(uplodMsg, '', '', FromFile, Istream);
        if FromFile <> '' then begin
            FileName := FileManagement.GetFileName(FromFile);
            SheetName := TempExcelBuffer.SelectSheetsNameStream(Istream)
        end else
            Error(NoFileMsg);
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.OpenBookStream(Istream, SheetName);
        TempExcelBuffer.ReadSheet();
    end;

    local procedure GetCellValue(RowNo: Integer; ColNo: Integer): Text
    begin
        TempExcelBuffer.Reset();
        if TempExcelBuffer.Get(RowNo, ColNo) then
            exit(TempExcelBuffer."Cell Value As Text")
        else
            exit('');
    end;

    local procedure ImportExcelData()
    var
        ExcelImport: Record "Excel Import Buffer ";
        RowNo: Integer;
        ColNo: Integer;
        LineNo: Integer;
        MaxRow: Integer;
    begin
        RowNo := 0;
        ColNo := 0;
        LineNo := 0;
        MaxRow := 0;
        ExcelImport.Reset();
        if ExcelImport.FindFirst() then
            LineNo := ExcelImport."Line No.";
        TempExcelBuffer.Reset();
        if TempExcelBuffer.FindLast() then begin
            MaxRow := TempExcelBuffer."Row No.";
        end;
        for RowNo := 2 to MaxRow Do begin
            LineNo := LineNo + 10000;

            ExcelImport.Init();
            Evaluate(ExcelImport."Transaction Name", TransName1);
            ExcelImport."Line No." := LineNo;
            Evaluate(ExcelImport."Product No", GetCellValue(RowNo, 1));
            Evaluate(ExcelImport."Customer No", GetCellValue(RowNo, 2));
            Evaluate(ExcelImport.Date, GetCellValue(RowNo, 3));
            Evaluate(ExcelImport.Type, GetCellValue(RowNo, 4));
            Evaluate(ExcelImport."Payment Method", GetCellValue(RowNo, 5));
            Evaluate(ExcelImport.Quantity, GetCellValue(RowNo, 6));
            Evaluate(ExcelImport."Unit Price", GetCellValue(RowNo, 7));
            ExcelImport."Sheet Name" := SheetName;
            ExcelImport."File Name" := FileName;
            ExcelImport."Imported Date" := Today;
            ExcelImport."Impotred Time" := Time;
            ExcelImport.Insert();
        end;
        Message(ExcelImportSuccess);
    end;

    local procedure ExportExcelBuffer(var ImportExcel: Record "Excel Import Buffer ")
    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        ImportExcel1: Label 'Product Entries';
        ExcelFileName: Label 'Excel Entries_%1_%2';
    begin
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(ImportExcel.FieldCaption("Product No"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(ImportExcel.FieldCaption("Customer No"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(ImportExcel.FieldCaption(Date), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(ImportExcel.FieldCaption(Type), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(ImportExcel.FieldCaption("Payment Method"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(ImportExcel.FieldCaption(Quantity), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(ImportExcel.FieldCaption("Unit Price"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

        if ImportExcel.FindSet() then
            repeat
                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn(ImportExcel."Product No", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(ImportExcel."Customer No", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(ImportExcel.Date, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                TempExcelBuffer.AddColumn(ImportExcel.Type, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(ImportExcel."Payment Method", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(ImportExcel.Quantity, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(ImportExcel."Unit Price", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
            until ImportExcel.Next() = 0;

        TempExcelBuffer.CreateNewBook(ImportExcel1);
        TempExcelBuffer.WriteSheet(ImportExcel1, CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
        TempExcelBuffer.OpenExcel();
    end;
}
