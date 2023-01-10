page 50075 "Closed Maintenance List"
{
    CardPageID = "Repair & Maint. Job Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = 50032;
    SourceTableView = WHERE(Status = FILTER(Close));
    ApplicationArea = all;
    UsageCategory = Lists;
    //

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; rec."No.")
                {
                    Editable = false;
                }
                field("FA No."; rec."FA No.")
                {
                    Editable = false;
                }
                field("FA Description"; rec."FA Description")
                {
                    Editable = false;
                }
                field("Creation Date"; rec."Creation Date")
                {
                    Editable = false;
                }
                field("Start Date"; rec."Start Date")
                {
                    Editable = false;
                }
                field("End Date"; rec."End Date")
                {
                    Editable = false;
                }
                field("Location Code"; rec."Location Code")
                {
                    Editable = false;
                }
                field("Created By"; rec."Created By")
                {
                    Editable = false;
                }
                field(Status; rec.Status)
                {
                    Editable = false;
                }
                field(Remarks; rec.Remarks)
                {
                    Editable = false;
                }
                field("Vendor No."; rec."Vendor No.")
                {
                    Editable = false;
                }
                field("Vendor Name"; rec."Vendor Name")
                {
                    Editable = false;
                }
                field("Maintenance Type"; rec."Maintenance Type")
                {
                    Editable = false;
                }
                field("Incoming Document Entry No."; rec."Incoming Document Entry No.")
                {
                    Editable = false;
                }
                field("Work Order No."; rec."Work Order No.")
                {
                    Editable = false;
                }
                field(Component; rec.Component)
                {
                    Editable = false;
                }
                field("Component Description"; rec."Component Description")
                {
                    Editable = false;
                }
                field("Sub-Component 1"; rec."Sub-Component 1")
                {
                    Editable = false;
                }
                field("Sub-Component 1 Description"; rec."Sub-Component 1 Description")
                {
                    Editable = false;
                }
                field("Sub-Component 2"; rec."Sub-Component 2")
                {
                    Editable = false;
                }
                field("Sub-Component 2 Description"; rec."Sub-Component 2 Description")
                {
                    Editable = false;
                }
                field("Description of the Problem"; rec."Description of the Problem")
                {
                    Editable = false;
                }
                field("Nature of Problem"; rec."Nature of Problem")
                {
                    Editable = false;
                }
                field("What Was Done"; rec."What Was Done")
                {
                    Editable = false;
                }
                field("Est. Production Loss (MT)"; rec."Est. Production Loss (MT)")
                {
                    Editable = false;
                }
                field("Category Of Problem"; rec."Category Of Problem")
                {
                    Editable = false;
                }
                field("Creation Date-Time"; rec."Creation Date-Time")
                {
                    Editable = false;
                }
                field("Break-Down Since"; rec."Break-Down Since")
                {
                    Editable = false;
                }
                field("Maintenance Activity Start"; rec."Maintenance Activity Start")
                {
                    Editable = false;
                }
                field("Maintenance Activity Finish"; rec."Maintenance Activity Finish")
                {
                    Editable = false;
                }
                field("Production Restart"; rec."Production Restart")
                {
                    Editable = false;
                }
                field("Root Cause"; rec."Root Cause")
                {
                    Editable = false;
                }
                field("Resource Provider"; rec."Resource Provider")
                {
                    Editable = false;
                }
                field("Is it a Production Loss"; rec."Is it a Production Loss")
                {
                    Editable = false;
                }
                field("Fault Found or Not"; rec."Fault Found or Not")
                {
                    Editable = false;
                }
                field("Consumable Stockout"; rec."Consumable Stockout")
                {
                    Editable = false;
                }
                field("Hours Consumed In Stockout"; rec."Hours Consumed In Stockout")
                {
                    Editable = false;
                }
                field("Total Man Hours Utilized"; rec."Total Man Hours Utilized")
                {
                    Editable = false;
                }
                field("Final Comments"; rec."Final Comments")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnDeleteRecord(): Boolean
    begin
        IF rec.Status = rec.Status::Close THEN
            ERROR('When status is Close then this action is not authorized');
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF rec.Status = rec.Status::Close THEN
            ERROR('When status is Close then this action is not authorized');

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        IF rec.Status = rec.Status::Close THEN
            ERROR('When status is Close then this action is not authorized');
    end;
}

