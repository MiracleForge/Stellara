function Pilot(_name, _faction) constructor {
    name = _name;
    faction = _faction;

    // comum a qualquer piloto (player ou NPC)
    static getInfo = function() {
        return {
            type: "pilot",
            fields: [
                {
                    label: "Pilote",
                    value: name
                }
            ]
        };
    }
}

function PlayerPilot(_name, _faction) : Pilot(_name, _faction) constructor {
    money = 0;
    reputation = 0;
    // aqui entra tudo que só o jogador tem: progressão, xp, etc.
}

function PilotNPC(_name, _faction) : Pilot(_name, _faction) constructor {
    // dados de IA/comportamento do piloto NPC
    money = irandom_range(50, 500);
}