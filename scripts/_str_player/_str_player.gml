function Player(_x, _y, _pilot_name, _shipType, _ship_name, _faction) constructor {
    pilot = new PlayerPilot(_pilot_name, _faction);
    ship  = new PlayerShip(_x, _y, _shipType, _ship_name, _faction);

    static getTransponder = function() {
        return {
            type: "player",
            faction: pilot.faction,
            transponder: true,
            fields: [], // pode reaproveitar pilot.getInfo().fields se quiser achatar
            children: [
                pilot.getInfo(),
                ship.getInfo()
            ]
        };
    }
}