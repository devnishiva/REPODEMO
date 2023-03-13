page 50308 PictureURLDialog
{
    PageType = StandardDialog;
    Caption = 'PictureURLDilog';

    layout
    {
        area(Content)
        {
            field(ItemNo; ItemNo)
            {
                ApplicationArea = All;
                Caption = 'ItemNo';
                Editable = false;
            }
            field(ItemDescription; ItemDescription)
            {
                ApplicationArea = All;
                Caption = 'ItemDescription';
                Editable = false;
            }
            field(PictureURL; PictureURL)
            {
                ApplicationArea = All;
                Caption = 'PictureURL';
                ExtendedDatatype = URL;
            }
        }
    }
    var
        ItemNo: Code[20];
        ItemDescription: Text[20];
        PictureURL: Text;

    procedure SetItemInfo(NewItemNo: Code[20]; NewItemDesc: Text[100])
    begin
        ItemNo := NewItemNo;
        ItemDescription := NewItemDesc;
    end;

    procedure ImportItemPictureFromURL()
    var
        Item: Record Item;
        Client: HttpClient;
        Content: HttpContent;
        Response: HttpResponseMessage;
        InStr: InStream;
    begin
        Client.Get(PictureURL, Response);
        Response.Content.ReadAs(InStr);
        if Item.Get(ItemNo) then begin
            Clear(Item.Picture);
            Item.Picture.ImportStream(InStr, 'Demo picture for item ' + Format(Item."No."));
            Item.Modify(true);
        end;
    end;
}