pageextension 50210 GLAccount_Ext extends "G/L Account Card"
{
    layout
    {
        addafter(Balance)
        {
            field("Repair & Maintenance"; Rec."Repair & Maintenance")
            {
                ApplicationArea = all;
            }
        }
    }
}
