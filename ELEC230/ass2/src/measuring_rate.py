import VL53L1X
import time

tof = VL53L1X.VL53L1X(i2c_bus=1, i2c_address=0x29)
tof.open()
tof.set_timing(20000, 25)
tof.start_ranging(0)

for i in range(0, 30):
    start_time = time.time()
    distance = round(tof.get_distance()/10)
    print(time.time() - start_time)

tof.stop_ranging()
