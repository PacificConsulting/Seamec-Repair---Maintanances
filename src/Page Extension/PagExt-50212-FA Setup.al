pageextension 50212 "FA Setup Ext" extends "Fixed Asset Setup"
{
    layout
    {
        addafter("Allow Posting to Main Assets")
        {
            field(Rec; Rec."Maintenance Nos.")
            {
                ApplicationArea = all;
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