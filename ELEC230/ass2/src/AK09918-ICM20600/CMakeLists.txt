add_library(AK09918-ICM20600 SHARED rpi_icm20600.c rpi_ak09918.c rpi_i2c.c)
target_include_directories(AK09918-ICM20600 PUBLIC .)