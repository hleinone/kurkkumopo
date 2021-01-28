$fa=5;
$fs=0.5;

module nose() {
    rotate([0,0,-90]) {
        union() {
            difference() {
                cylinder(5,3,0.5);
                translate([-2,3.5,0]) {
                    rotate([30,20,0]) {
                        cylinder(5.5,3,0.5);
                    }
                }
                translate([-2,-3.5,0]) {
                    rotate([-30,20,0]) {
                        cylinder(5.5,3,0.5);
                    }
                }
            }
            translate([-2.3,0,-0.5]) {
                rotate([0,20,0]) {
                    cylinder(5.5,1,0.5);
                }
            }
        }
    }
    translate([0,0.4,5.5]) {
        sphere(1.7);
    }
}

module mouth() {
    difference() {
        sphere(6);
        translate([0,0,3]) {
            cylinder(8,8,8,true);
        }
        translate([-2.5,0,-3.5]) {
            sphere(8);
        }
    }
}

module head() {
    render(convexity=2) {
        difference() {
            union() {
                sphere(8);
                translate([0,1.5,5.5]) {
                    nose();
                }
                // Handlebar holder
                translate([0,4.5,-1]) {
                    rotate([-40,0,0]) {
                        union() {
                            difference() {
                                cube([2,10,10],true);
                                translate([0,23.5,-4.2]) {
                                    rotate([0,90,0]) {
                                        cylinder(3,20,20,true);
                                    }
                                }
                            }
                            translate([0,5,5]) {
                                rotate([0,90,0]) {
                                    cylinder(3,1.7,1.7,true);
                                }
                            }
                        }
                    }
                }
            }
            // Eye sockets
            translate([3.5,4,5.8]) {
                rotate([25,30,92]) {
                    cylinder(0.6,1.6,1.6,true);
                }
            }
            translate([-3.5,4,5.8]) {
                rotate([-25,30,92]) {
                    cylinder(0.6,1.6,1.6,true);
                }
            }
            translate([0,3.5,6]) {
                rotate([180,0,-90]) {
                    mouth();
                }
            }
        }
    }
}

curveDiffX = 5.6;
curveDiffY = 3;
module torso() {
    distance = 100;
    translate([-distance,0,0]) {
        rotate_extrude(angle=14,convexity=1,$fn=1000) {
            translate([distance, 0, 0]) {
                circle(8);
            }
        }
    }
}

module bodyTemp() {
    render(convexity=2) {
        union() {
            translate([0,curveDiffY,24.2]) {
                rotate([-3,0,0]) {
                    head();
                }
            }
            rotate([90,0,-90]) {
                torso();
            }
            sphere(8);
        }
    }    
}

module saddle() {
    difference() {
        translate([-5,1,27]) {
            rotate([-90,0,0]) {
                linear_extrude(10,true,convexity=2) {
                    scale([0.1,0.1,0.1]) {
                        import("pattern-top.dxf");
                    }
                }
            }
        }
        bodyTemp();
    }
}

module leftPattern() {
    difference() {
        translate([0,-0.5,29]) {
            rotate([90,98,90]) {
                linear_extrude(10,true,convexity=2) {
                    scale([0.1,0.1,0.1]) {
                        import("pattern-left.dxf");
                    }
                }
            }
        }
        bodyTemp();
    }
}

module rightPattern() {
    difference() {
        translate([-10,-0.5,29]) {
            rotate([90,98,90]) {
                linear_extrude(10,true,convexity=2) {
                    scale([0.1,0.1,0.1]) {
                        import("pattern-right.dxf");
                    }
                }
            }
        }
        bodyTemp();
    }
}

// Body
module body() {
    color("PaleGreen") {
        rotate([90,0,0]) {
            difference() {
                union() {
                    bodyTemp();
                    
                    // Front wheel axis holder
                    translate([0,-5.2 + curveDiffY,24]) {
                        rotate([0,90,0]) {
                            cylinder(11,3,3,true);
                        }
                    }
                    // Back wheel axis holder
                    translate([0,-5,0]) {
                        rotate([0,90,0]) {
                            cylinder(11,3,3,true);
                        }
                    }
                }
                // Front wheel indents
                translate([-8,-7 + curveDiffY,24.5]) {
                    rotate([0,90,0]) {
                        cylinder(5,5,5,true);
                    }
                }
                translate([8,-7 + curveDiffY,24.5]) {
                    rotate([0,90,0]) {
                        cylinder(5,5,5,true);
                    }
                }
                // Back wheel indents
                translate([-8,-7,0]) {
                    rotate([0,90,0]) {
                        cylinder(5,5,5,true);
                    }
                }
                translate([8,-7,0]) {
                    rotate([0,90,0]) {
                        cylinder(5,5,5,true);
                    }
                }
                // Front wheel axis hole
                translate([0,-7 + curveDiffY,24.5]) {
                    rotate([0,90,0]) {
                        cylinder(20,0.5,0.5,true);
                    }
                }
                // Back wheel axis hole
                translate([0,-7,0]) {
                    rotate([0,90,0]) {
                        cylinder(20,0.5,0.5,true);
                    }
                }
                // Handlebar hole
                translate([0,11.5 + curveDiffY,23.2]) {
                    rotate([0,90,0]) {
                        cylinder(20,handlebarThickness + 0.1,handlebarThickness + 0.1,true);
                    }
                }
                translate([-0.2,0,0]) {
                    leftPattern();
                }
                translate([0.2,0,0]) {
                       rightPattern();
                }
                translate([0,-0.2,0]) {
                    saddle();
                }                
            }
        }
    }
}

body();

handlebarThickness = 0.8;
module handlebar() {
    color("Red") {
        translate([0,0,8]) {
            sphere(handlebarThickness);
        }
        translate([0,0,-8]) {
            sphere(handlebarThickness);
        }
        cylinder(16,handlebarThickness,handlebarThickness,true);
    }
}
// Handlebar
translate([0,-23.2,11.5 + curveDiffY]) {
    rotate([0,90,0]) {
        handlebar();
    }
}

// Wheels
wheelWidth = 1.5;

module wheel() {
    color("Red") {
        rotate([0,90,0]) {
            difference() {
                union() {
                    difference() {
                        cylinder(wheelWidth,4,4,true);
                        translate([0,0,0.6]) {
                            cylinder(0.5,2.8,2.8,true);
                        }
                    }
                    translate([0,0,0.6]) {
                        cylinder(0.5,3,0,true);
                    }
                }
                cylinder(5,0.5,0.5,true);
            }
        }
    }
}
translate([6.5,0,-7]) {
    wheel();
    translate([wheelWidth,0,0]) {
        axisKnob();
    }
}
translate([-6.5,0,-7]) {
    rotate([0,180,0]) {
        wheel();
        translate([wheelWidth,0,0]) {
            axisKnob();
        }
    }
}
translate([6.5,-24.5,-7 + curveDiffY]) {
    wheel();
    translate([wheelWidth,0,0]) {
        axisKnob();
    }
}
translate([-6.5,-24.5,-7 + curveDiffY]) {
    rotate([0,180,0]) {
        wheel();
        translate([wheelWidth,0,0]) {
            axisKnob();
        }
    }
}

module axisKnob() {
    color("Black") {
        rotate([0,-90,0]) {
            difference() {
                cylinder(0.9,0.9,0.9,true);
                translate([0.,0,0.5]) {
                    cylinder(1,0.45,0.45,true);
                }
            }
        }
    }
}

// Antennae
module antenna() {
    color("Red") {
        union() {
            cylinder(8,0.2,0.2);
            translate([0,0,8]) {
                sphere(0.5);
            }
        }
    }
}
translate([0,-27.5,7 + curveDiffY]) {
    rotate([35,35,0]) {
        antenna();
    }
}
translate([0,-27.5,7 + curveDiffY]) {
    rotate([35,-35,0]) {
        antenna();
    }
}