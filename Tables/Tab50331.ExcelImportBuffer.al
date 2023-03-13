table 50331 "Excel Import Buffer"
{
    Caption = 'Excel Import Buffer ';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Transaction Name"; Code[10])
        {
            Caption = 'Transaction Name';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "File Name"; Text[100])
        {
            Caption = 'File Name';
            DataClassification = CustomerContent;
        }
        field(4; "Sheet Name"; Text[100])
        {
            Caption = 'Sheet Name';
            DataClassification = CustomerContent;
        }
        field(5; "Imported Date"; Date)
        {
            Editable = false;
            Caption = 'Imported Date';
            DataClassification = CustomerContent;
        }
        field(6; "Impotred Time"; Time)
        {
            Editable = false;
            Caption = 'Impotred Time';
            DataClassification = CustomerContent;
        }
        field(7; "Customer No"; Code[30])
        {
            Caption = 'Customer No';
            DataClassification = CustomerContent;
        }
        field(8; "Product No"; Code[30])
        {
            Caption = 'Product No';
            DataClassification = CustomerContent;
        }
        field(9; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(10; Type; Enum "Sales Line Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(11; "Payment Method"; Text[30])
        {
            Caption = 'Payment Method';
            DataClassification = CustomerContent;
        }
        field(12; Quantity; Integer)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(13; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Transaction Name", "Line No.")
        {
            Clustered = true;
        }
    }
    var
        cus: Page "Customer Card";
        cust: Record Customer;
}
