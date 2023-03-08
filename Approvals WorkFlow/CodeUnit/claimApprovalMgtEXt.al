codeunit 50515 ClaimApprovalflow
{
    trigger OnRun()
    begin

    end;

    var
        NoWorkflowEnabledErr: TextConst ENU = 'No Approval WorkFlows for this Record Type is enabled';
        WorkFlowManagemnet: Codeunit 1501;
    //WorkFlowEventHandlingCust :Codeunit 60012;

    procedure CheckClaimApprovalsworkflowEnable(var claim: Record ClaimManagement): Boolean
    begin
        if not CheckClaimApprovalsworkflowEnable(claim) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsClaimDocApprovalSWorkFlowEnabled(var Claim: Record ClaimManagement): Boolean
    begin
        if Claim."Approvel Status" <> Claim."Approvel Status"::Open then
            exit(false);
        //exit(WorkFlowManagemnet.CanExecuteWorkflow(Claim))
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendClaimApproval(var Claim: Record ClaimManagement)
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelClaimApproval(var Claim: Record ClaimManagement)
    begin

    end;
}