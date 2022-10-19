
entity port_con is
  port ( b: in bit_vector(2 downto 0));
end;

architecture port_con of port_con is
begin
end;

entity tb is
end;

architecture tb of tb is
  component port_con
    port ( b: in bit_vector(2 downto 0));
  end component;
  signal  rst: bit;
  signal dat: bit_vector (1 downto 0);
  signal tmp: bit_vector (2 downto 0);
begin
  tmp <= rst & dat;
  i0: port_con port map (b(0) => rst, b(1 downto 0) => dat);
  i1: port_con port map (b =>tmp);
end;
