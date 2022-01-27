package global.org.minima.kissvm.functions.sigs;

import global.org.minima.kissvm.Contract;
import global.org.minima.kissvm.exceptions.ExecutionException;
import global.org.minima.kissvm.functions.MinimaFunction;
import global.org.minima.kissvm.values.BooleanValue;
import global.org.minima.kissvm.values.HexValue;
import global.org.minima.kissvm.values.Value;

public class SIGNEDBY extends MinimaFunction {

	public SIGNEDBY() {
		super("SIGNEDBY");
	}
	
	@Override
	public Value runFunction(Contract zContract) throws ExecutionException {
		checkExactParamNumber(requiredParams());
		
		//get the Pub Key
		HexValue pubkey = zContract.getHexParam(0, this);
		
		//Check it..
		boolean valid = zContract.checkSignature(pubkey);
		
		//return value
		return new BooleanValue(valid);
	}

	@Override
	public int requiredParams() {
		return 1;
	}
	
	@Override
	public MinimaFunction getNewFunction() {
		return new SIGNEDBY();
	}
}
