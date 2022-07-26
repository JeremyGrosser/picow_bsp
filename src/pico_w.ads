with RP.Device;
with RP.Clock;
with RP.GPIO;
with GSPI;
with CYW43;

package Pico_W is

   WL_ON  : aliased RP.GPIO.GPIO_Point := (Pin => 23);
   WL_D   : aliased RP.GPIO.GPIO_Point := (Pin => 24);
   WL_CS  : aliased RP.GPIO.GPIO_Point := (Pin => 25);
   WL_CLK : aliased RP.GPIO.GPIO_Point := (Pin => 29);

   --  WL_ON  : aliased RP.GPIO.GPIO_Point := (Pin => 3);
   --  WL_D   : aliased RP.GPIO.GPIO_Point := (Pin => 4);
   --  WL_CS  : aliased RP.GPIO.GPIO_Point := (Pin => 5);
   --  WL_CLK : aliased RP.GPIO.GPIO_Point := (Pin => 9);

   GSPI_0 : aliased GSPI.GSPI_Port
      (PIO     => RP.Device.PIO_0'Access,
       SM      => 0,
       Offset  => 0,
       CLK     => WL_CLK'Access,
       DAT     => WL_D'Access,
       CS      => WL_CS'Access,
       Delays  => RP.Device.Timer'Access,
       Channel => 0);

   WLAN : aliased CYW43.Device
      (Port    => GSPI_0'Access,
       REG_ON  => WL_ON'Access);

   XOSC_Frequency     : constant RP.Clock.XOSC_Hertz  := 12_000_000;
   XOSC_Startup_Delay : constant RP.Clock.XOSC_Cycles := 12_032;

end Pico_W;
