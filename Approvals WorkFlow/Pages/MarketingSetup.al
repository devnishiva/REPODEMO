pageextension 50160 MarketingSetupEX extends "Marketing Setup"
{
    layout
    {
        addafter("Opportunity Nos.")
        {
            field("Claim Nos"; Rec."Claim Nos")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}