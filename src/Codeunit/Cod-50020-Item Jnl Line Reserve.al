codeunit 50020 "Item Jnl. Line Reserve"
{
    trigger OnRun()
    begin

    end;

    procedure MyProcedure()
    var
        myInt: Integer;
    begin

    end;

    var

    procedure CallItemTrackingML(VAR MaintenanceLine: Record "Maintenance Line"; IsReclass: Boolean)
    var

        TrackingSpecification: Record "Tracking Specification";
        ReservEntry: Record "Reservation Entry";
        ItemTrackingForm: Page "Item Tracking Lines";
    begin
        MaintenanceLine.TESTFIELD("Consumable Component");
        InitTrackingSpecificationML(MaintenanceLine, TrackingSpecification);
        IF IsReclass THEN
            //ItemTrackingForm.SetFormRunMode(1); //PCPL/NSW/07 Below ne code added for BC
            ItemTrackingForm.SetRunMode("Item Tracking Run Mode"::Reclass);
        //ItemTrackingForm.SetSource(TrackingSpecification, WORKDATE);//PCPL/NSW/07 Below ne code added for BC
        ItemTrackingForm.SetSourceSpec(TrackingSpecification, WORKDATE);
        //Itemtrackingform.
        ItemTrackingForm.SetInbound(FALSE);
        ItemTrackingForm.RUNMODAL;
    end;

    Procedure InitTrackingSpecificationML(VAR MaintenanceLine: Record "Maintenance Line"; VAR TrackingSpecification: Record "Tracking Specification")
    var
        recItem: record 27;
    begin
        TrackingSpecification.INIT;
        TrackingSpecification."Source Type" := DATABASE::"Maintenance Line";
        //WITH MaintenanceLine DO BEGIN
        TrackingSpecification."Item No." := MaintenanceLine."Consumable Component";
        TrackingSpecification."Location Code" := MaintenanceLine."Location Code";
        IF recItem.GET(MaintenanceLine."Consumable Component") THEN;
        TrackingSpecification.Description := recItem.Description;
        TrackingSpecification."Variant Code" := '';
        TrackingSpecification."Source Subtype" := 3;
        TrackingSpecification."Source ID" := 'ITEM';
        TrackingSpecification."Source Batch Name" := 'DEFAULT';
        TrackingSpecification."Source Prod. Order Line" := 0;
        TrackingSpecification."Source Ref. No." := MaintenanceLine."Line No.";
        TrackingSpecification."Quantity (Base)" := MaintenanceLine.Quantity;
        TrackingSpecification."Qty. to Handle" := MaintenanceLine.Quantity;
        TrackingSpecification."Qty. to Handle (Base)" := MaintenanceLine.Quantity;
        TrackingSpecification."Qty. to Invoice" := MaintenanceLine.Quantity;
        TrackingSpecification."Qty. to Invoice (Base)" := MaintenanceLine.Quantity;
        TrackingSpecification."Quantity Handled (Base)" := 0;
        TrackingSpecification."Quantity Invoiced (Base)" := 0;
        TrackingSpecification."Qty. per Unit of Measure" := recItem."Unit Price";
        TrackingSpecification."Bin Code" := MaintenanceLine."Bin Code";
        // END;
    end;

}