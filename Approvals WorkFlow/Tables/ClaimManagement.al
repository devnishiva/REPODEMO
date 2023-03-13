table 50152 ClaimManagement1
{
    DataClassification = CustomerContent;
    Caption = 'Claim Management';
    fields
    {
        field(1; "No."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            trigger OnValidate()
            var
                marketingsetup: Record "Marketing Setup";
                NoseriecManagamnet: Codeunit NoSeriesManagement;
            begin
                if "No." <> xRec."No." then begin
                    marketingsetup.Get();
                    NoseriecManagamnet.TestManual(marketingsetup."Claim Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Claim Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "",Commercial,Technical;
            OptionCaption = '"",Commercial,Technical';
        }
        field(3; "Claim Description"; Blob)
        {
            DataClassification = CustomerContent;
            Caption = 'Claim Description';
        }
        field(4; "Customer N0."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer;
            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                if Customer.get("Customer N0.") then
                    "Customer Name" := Customer.Name;
                "Customer Phone" := Customer."Phone No.";
                Customer.Modify();
            end;
        }
        field(5; "Customer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Customer Phone"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Claim Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "SalesPersonCode"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Sales Person Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(9; "Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Open,Pending,Colse;
            OptionCaption = 'Open,Pending,Colse';
        }
        field(10; "Approvel Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Open,"Approvel Opending",Relesed;
            OptionCaption = 'Open,Approvel Opending,Relesed';
        }
        field(11; "No. Series"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }

    }

    keys
    {
        key(Pk; "No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        marketingsetup: Record "Marketing Setup";
        NoseriecManagamnet: Codeunit NoSeriesManagement;
    begin
        if "No." = '' then begin
            marketingsetup.Get();
            marketingsetup.TestField("Claim Nos");
            NoseriecManagamnet.InitSeries(marketingsetup."Claim Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;
}