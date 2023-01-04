page 50053 "Maintenance FA SubPage"
{
    AutoSplitKey = true;
    Caption = 'Job task FA Line';
    PageType = ListPart;
    SourceTable = 50021;
    SourceTableView = WHERE("Component Type" = FILTER(FA));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Component Type"; rec."Component Type")
                {
                }
                field("Consumable Component"; rec."Consumable Component")
                {
                }
                field(Remarks; rec.Remarks)
                {
                }
                field(Description; rec.Description)
                {
                }
                field(Quantity; rec.Quantity)
                {
                }
                field("Location Code"; rec."Location Code")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                }
                action(ItemTrackingLines)
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';
                    Visible = false;

                    trigger OnAction()
                    begin
                        rec.OpenItemTrackingLines(FALSE);

                    end;
                }
            }
        }
    }
}

