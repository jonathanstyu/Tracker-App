# This file is automatically generated. Do not edit.

if Object.const_defined?('TestFlight') and !UIDevice.currentDevice.model.include?('Simulator')
  NSNotificationCenter.defaultCenter.addObserverForName(UIApplicationDidBecomeActiveNotification, object:nil, queue:nil, usingBlock:lambda do |notification|
  TestFlight.setDeviceIdentifier(UIDevice.currentDevice.uniqueIdentifier)
  TestFlight.takeOff('b358f1b4-fe79-43aa-9ce9-78417fc89d87')
  end)
end
