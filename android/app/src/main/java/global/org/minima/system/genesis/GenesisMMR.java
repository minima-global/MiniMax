package global.org.minima.system.genesis;

import global.org.minima.database.mmr.MMR;
import global.org.minima.database.mmr.MMRData;
import global.org.minima.objects.Coin;
import global.org.minima.objects.base.MiniData;
import global.org.minima.objects.base.MiniNumber;
import global.org.minima.utils.Crypto;

public class GenesisMMR extends MMR {

	public GenesisMMR() {
		super();
		
		//This is begore the big bang..
		setBlockTime(MiniNumber.ZERO);
		
		//Add 1 entry.. the genesis coin..
		Coin gencoin = new GenesisCoin();
		
		//Get the Hash of this 
		MiniData hashunspent = Crypto.getInstance().hashObject(new GenesisCoin());
		
		//And create a new MMRData with the correct amount
		MMRData mmrdata = new MMRData(hashunspent, gencoin.getAmount());
		
		//And add to the MMR
		addEntry(mmrdata);
		
		//It's done..
		finalizeSet();
	}
}
