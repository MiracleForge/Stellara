function Player(_x, _y, _pilot_name, _shipType, _ship_name, _faction) constructor {
    pilot = new PlayerPilot(_pilot_name, _faction);
    ship  = new PlayerShip(_x, _y, _shipType, _ship_name, _faction);

    static getTransponder = function() {
        return {
            type: "player",
            faction: pilot.faction,
            transponder: ship.identity.transponder_active, 
            fields: [],
            children: [
                pilot.getInfo(),
                ship.getInfo()
            ]
        };
    }
}