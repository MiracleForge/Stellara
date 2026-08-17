function ShipEntity(_x, _y, _pilot_name, _ship_data, _ship_name, _faction) constructor {
    pilot = new PilotNPC(_pilot_name, _faction);
    ship  = new ShipNPC(_x, _y, _ship_data, _ship_name, _faction);

    static getTransponder = function() {
        return {
            type: "ship_entity",
            faction: ship.identity.faction,
            transponder: ship.identity.transponder_active,
            fields: [],
            children: [
                pilot.getInfo(),
                ship.getInfo()
            ]
        };
    }
}