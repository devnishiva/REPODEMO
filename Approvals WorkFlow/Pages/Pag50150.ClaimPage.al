page 50151 ClaimPage
{
    Caption = 'ClaimPage';
    PageType = Card;
    SourceTable = ClaimManagement;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Customer N0."; Rec."Customer N0.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer N0. field.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field("Customer Phone"; Rec."Customer Phone")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Phone field.';
                }
                field("Claim Date"; Rec."Claim Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Claim Date field.';
                }
                field("Claim Type"; Rec."Claim Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Claim Type field.';
                }
                field(SalesPersonCode; Rec.SalesPersonCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales Person Code field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Claim Description"; Rec."Claim Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Claim Description field.';
                }
                field("Approvel Status"; Rec."Approvel Status")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("Request Approvals")
            {
                action("Sending Approvals Request")
                {
                    Visible = OpenApprovalEntriesExitForCUrrUser;
                    Image = Approve;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    trigger OnAction()
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action("Send A&pproval Request")
                {
                    Visible = not OpenApprovalEntriesExist And CanRequsestApprovalForFlow;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    trigger OnAction()
                    begin
                        if claimApprovalflow.CheckClaimApprovalsworkflowEnable(Rec) then;

                    end;
                }
            }
        }
    }
    var
        OpenApprovalEntriesExitForCUrrUser: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        approvalsMgmtCut: Codeunit Approvals;
        WorkFlowWebhookMgt: Codeunit 1543;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalsForRecord: Boolean;
        CanCancelApprovalsForFlow: Boolean;
        CanRequsestApprovalForFlow: Boolean;
        claimApprovalflow: Codeunit ClaimApprovalflow;
}
