pageextension 50400 ItemPictureExt extends "Item Picture"
{
    actions
    {
        addafter(ImportPicture)
        {
            action(ExportPictureFromUrl)
            {
                ApplicationArea = all;
                Caption = 'Import From Url';
                Image = Import;
                ToolTip = 'Executes the Import From Url action.';
                trigger OnAction()
                var
                    PictureURL: Page PictureURLDialog;
                begin
                    PictureURL.SetItemInfo(Rec."No.", Rec.Description);
                    if PictureURL.RunModal() = Action::OK then
                        PictureURL.ImportItemPictureFromURL();
                end;
            }
        }
    }
}
