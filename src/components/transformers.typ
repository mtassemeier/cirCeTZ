#import "../component.typ": component
#import "inductors.typ": inductor
#import "../dependencies.typ": cetz

#import cetz.draw: *

#let transformers(
  style,
  ..inputs
) = component(
  "transformers",
  (style) => {
    let height = style.height
    let height2 = style.height / 2
    let height8 = style.height / 8

    let width2 = style.width / 2
    let width4 = style.width / 4
    let width8 = style.width / 8

    anchor("text", (
      0,
      height2
    ))

    anchor("A1", (-width2, height2))  
    anchor("A2", (-width2, -height2))
  
    anchor("B1", (width2, height2))  
    anchor("B2", (width2, -height2))

    line("A1", (rel: (width4, 0)), stroke: style.stroke.thickness)
    inductor((), (rel: (0, -height)), width: width2, name: "inductor1")
    line((), "A2", stroke: style.stroke.thickness)

    line("B1", (rel: (-width4, 0)), stroke: style.stroke.thickness)
    inductor((), (rel: (0, -height)), width: width2, mirror: true, name: "inductor2")
    line((), "B2", stroke: style.stroke.thickness)


    anchor("inner dot A1", (-width8, height2 - height8))  
    anchor("inner dot A2", (-width8, -height2 + height8))
  
    anchor("inner dot B1", (width8, height2 - height8))  
    anchor("inner dot B2", (width8, -height2 + height8))

    let idot = inputs.named().at("inner-dot", default: (:))

    for i in idot {
      assert(i in ("A1", "A2", "B1", "B2"),  message: "Dot must be A1 or A2 or B1 or B2")      
      circle("inner dot " + i, radius: height / 40, fill: black)
    }

    anchor("outer dot A1", (-width4 - width8, height2 - height8))  
    anchor("outer dot A2", (-width4 - width8, -height2 + height8))
  
    anchor("outer dot B1", (width4 + width8, height2 - height8))  
    anchor("outer dot B2", (width4 + width8, -height2 + height8))

    let odot = inputs.named().at("outer-dot", default: (:))

    for i in odot {
      assert(i in ("A1", "A2", "B1", "B2"),  message: "Dot must be A1 or A2 or B1 or B2")      
      circle("outer dot " + i, radius: height / 40, fill: black)
    }

    let core = inputs.named().at("core", default: false) 

    if core {
      line((style.width / 24, height / 4), (rel :(0, -height2)), stroke: style.stroke.thickness)
      line((-style.width / 24, height / 4), (rel :(0, -height2)), stroke: style.stroke.thickness)
    }
  },
    (
    stroke: auto,
    thickness: auto,
    scale: auto,
    width: 1.2,
    height: 1.5,
  ),
  ..inputs
)

#let transformer = transformers.with((style: auto))
