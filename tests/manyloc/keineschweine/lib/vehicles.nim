import
  sfml, chipmunk, 
  sg_assets, sfml_stuff, keineschweine


proc accel*(obj: PVehicle, dt: Float) =
  #obj.velocity += vec2f(
  #  cos(obj.angle) * obj.record.handling.thrust.float * dt,
  #  sin(obj.angle) * obj.record.handling.thrust.float * dt)
  obj.body.applyImpulse(
    vectorForAngle(obj.body.getAngle()) * dt * obj.record.handling.thrust,
    vectorZero)
proc reverse*(obj: PVehicle, dt: Float) =
  #obj.velocity += vec2f(
  #  -cos(obj.angle) * obj.record.handling.reverse.float * dt,
  #  -sin(obj.angle) * obj.record.handling.reverse.float * dt)
  obj.body.applyImpulse(
    -vectorForAngle(obj.body.getAngle()) * dt * obj.record.handling.reverse,
    vectorZero)
proc strafeLeft*(obj: PVehicle, dt: Float) =
  obj.body.applyImpulse(
    vectorForAngle(obj.body.getAngle()).perp() * obj.record.handling.strafe * dt,
    vectorZero)
proc strafeRight*(obj: PVehicle, dt: Float) =
  obj.body.applyImpulse(
    vectorForAngle(obj.body.getAngle()).rperp()* obj.record.handling.strafe * dt,
    vectorZero)
proc turnRight*(obj: PVehicle, dt: Float) =
  #obj.angle = (obj.angle + (obj.record.handling.rotation.float / 10.0 * dt)) mod TAU
  obj.body.setTorque(obj.record.handling.rotation)
proc turnLeft*(obj: PVehicle, dt: Float) =
  #obj.angle = (obj.angle - (obj.record.handling.rotation.float / 10.0 * dt)) mod TAU
  obj.body.setTorque(-obj.record.handling.rotation)
proc offsetAngle*(obj: PVehicle): Float {.inline.} =
  return (obj.record.anim.angle + obj.body.getAngle())
