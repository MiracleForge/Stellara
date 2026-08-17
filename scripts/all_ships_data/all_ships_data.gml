global.ship_types = {

    uss_cerulean: {
        
        shipInfo: {
            class: "Fighter"
        },
        
        sprite:  spr_uss_cerulean,

        stats: {
            acceleration: 0.5,
            max_speed: 0.8,
            turn_speed: 0.9,
            friction: 0.005,
            hyper_time: 3
        },

        shield: {
            max: 100
        }
    },
    
     maca_zin: {
        shipInfo: {
            class: "Destroyer"
        },
        sprite: spr_space_test, 
        stats: {
            acceleration: 0.3,
            max_speed: 0.5,
            turn_speed: 0.4,
            friction: 0.008,
            hyper_time: 5
        },
        shield: {
            max: 250
        }
    }
};