codeunit 50127 Approvals
{
    trigger OnRun()
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure onSendClaimForApprovals(var Claim: Record ClaimManagement)
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure onCancelClaimForApprovals(var Claim: Record ClaimManagement)
    begin

    end;
}