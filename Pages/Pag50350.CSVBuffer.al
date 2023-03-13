page 50350 "CSV Buffer"
{
    ApplicationArea = All;
    Caption = 'CSV Buffer';
    PageType = Worksheet;
    SourceTable = "CSV Buffer import1";
    UsageCategory = Tasks;
    AutoSplitKey = true;
    DelayedInsert = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    SaveValues = true;
    SourceTableView = sorting("Transaction Name", "Line No.");

    layout
    {
        area(content)
        {
            field(TransName; TransName)
            {
                ApplicationArea = All;
                Caption = 'TransName';
                ToolTip = 'Specifies the value of the TransName field.';
            }
            repeater(General)
            {
                Editable = false;
                field("Transaction Name"; Rec."Transaction Name")
                {
                    ApplicationArea = All;
                    Caption = 'Transaction Name';
                    ToolTip = 'Specifies the value of the Transaction Name field.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Line No.';
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Product No."; Rec."Product No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product No field.';
                    Caption = 'Product No';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer No. field.';
                    Caption = 'Customer No.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                    Caption = 'Date';
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
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Import)
            {
                ApplicationArea = All;
                Promoted = true;
                Image = Import;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Import action.';
                trigger OnAction()
                var
                begin
                    if TransName = '' then
                        Error(BatchIsBlackMsg);
                    ReadCsvData();
                    Importcsvdata();
                end;
            }
        }
    }
    local procedure ReadCsvData()
    var
        FileManagment: Codeunit "File Management";
        Istream: InStream;
        FromFile: Text[100];
    begin
        UploadIntoStream(Uploading, '', '', FromFile, Istream);
        if FromFile <> '' then begin
            FileName := FileManagment.GetFileName(FromFile)
        end else
            Error(NoFilemsg);
        TempcsvBuffer.Reset();
        TempcsvBuffer.DeleteAll();
        TempcsvBuffer.LoadDataFromStream(Istream, ',');
        TempcsvBuffer.GetNumberOfLines();
    end;

    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text
    begin
        TempcsvBuffer.Reset();
        if TempcsvBuffer.get(RowNo, ColNo) then
            exit(TempcsvBuffer.Value)
        else
            exit('');
    end;

    local procedure Importcsvdata()
    var
        GsImportBuffer: Record "CSV Buffer import1";
        RowNo: Integer;
        ColNo: Integer;
        LineNo: Integer;
        MaxRow: Integer;
    begin
        RowNo := 0;
        ColNo := 0;
        LineNo := 0;
        MaxRow := 0;
        GsImportBuffer.Reset();
        if GsImportBuffer.FindLast() then
            LineNo := GsImportBuffer."Line No.";
        TempcsvBuffer.Reset();
        if TempcsvBuffer.FindLast() then begin
            MaxRow := TempcsvBuffer."Line No.";
        end;
        for RowNo := 2 to MaxRow do begin
            LineNo := LineNo + 10000;
            GsImportBuffer.Init();
            Evaluate(GsImportBuffer."Transaction Name", TransName);
            GsImportBuffer."Line No." := LineNo;
            Evaluate(GsImportBuffer."Product No.", GetValueAtCell(RowNo, 1));
            Evaluate(GsImportBuffer."Customer No.", GetValueAtCell(RowNo, 2));
            Evaluate(GsImportBuffer.Date, GetValueAtCell(RowNo, 3));
            Evaluate(GsImportBuffer."Payment Method", GetValueAtCell(RowNo, 4));
            Evaluate(GsImportBuffer.Quantity, GetValueAtCell(RowNo, 5));
            Evaluate(GsImportBuffer."Unit Price", GetValueAtCell(RowNo, 6));
            GsImportBuffer.Insert();
        end;
        Message(CsvImportSuccess);
    end;

    var
        TransName: Text[20];
        FileName: Text[100];
        TempcsvBuffer: Record "CSV Buffer" temporary;
        Uploading: Label 'Please choose The CSV File';
        NoFilemsg: Label 'No CSV File Found';
        BatchIsBlackMsg: Label 'Transaction names is Blank';
        CsvImportSuccess: Label 'CSV File imported Successfully';
}
