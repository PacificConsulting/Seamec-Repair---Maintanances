page 50083 "Maintenance Manpower Used"
{
    AutoSplitKey = true;
    Caption = 'Maintenance Manpower Used';
    PageType = ListPart;
    SourceTable = 50033;
    SourceTableView = WHERE("Component Type" = FILTER(Resource));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Component Type"; rec."Component Type")
                {
                    ApplicationArea = all;
                }
                field("Resource Utilized"; rec."Consumable Component")
                {
                    ApplicationArea = all;
                }
                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Hours Utilized"; rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Unit Cost"; rec."Unit Cost")
                {
                    ApplicationArea = all;
                    Visible = True;//Visibility;
                }
                field("Location Code"; rec."Location Code")
                {
                    Visible = false;
                    ApplicationArea = all;
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

    trigger OnAfterGetRecord()
    begin

        UserSetup.GET(USERID);
        // IF UserSetup."Hide Resource Cost" THEN BEGIN
        //     Visibility := FALSE
        // END ELSE
        //     Visibility := TRUE;
    end;

    var
        UserSetup: Record 91;
        Visibility: Boolean;
}

