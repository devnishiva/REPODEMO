table 50341 "CSV Buffer import1"
{
    DataClassification = CustomerContent;
    Caption = 'CSV Buffer import';

    fields
    {
        field(1; "Transaction Name"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Transaction Name';
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No';
        }
        field(3; "Product No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Product No';
        }
        field(4; "Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer No.';
        }
        field(5; Date; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date';
        }
        field(6; "Payment Method"; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Method';
        }
        field(7; Quantity; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity';
        }
        field(8; "Unit Price"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Price';
        }
    }

    keys
    {
        key(PK; "Transaction Name", "Line No.")
        {
            Clustered = true;
        }
    }
}