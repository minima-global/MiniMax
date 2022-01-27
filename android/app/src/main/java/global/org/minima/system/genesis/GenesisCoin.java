package global.org.minima.system.genesis;

import global.org.minima.objects.Address;
import global.org.minima.objects.Coin;
import global.org.minima.objects.Token;
import global.org.minima.objects.base.MiniData;
import global.org.minima.objects.base.MiniNumber;

public class GenesisCoin extends Coin {

	public static final MiniData GENESIS_COINID = new MiniData("0x5350415254414355534C4F5645534D494E494D41");
	
	public GenesisCoin() {
		super(GENESIS_COINID, Address.TRUE_ADDRESS.getAddressData(), MiniNumber.BILLION, Token.TOKENID_MINIMA);
	}
	
}
