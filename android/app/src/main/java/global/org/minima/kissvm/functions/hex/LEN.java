package global.org.minima.kissvm.functions.hex;

import global.org.minima.kissvm.Contract;
import global.org.minima.kissvm.exceptions.ExecutionException;
import global.org.minima.kissvm.functions.MinimaFunction;
import global.org.minima.kissvm.values.HexValue;
import global.org.minima.kissvm.values.NumberValue;
import global.org.minima.kissvm.values.Value;

public class LEN extends MinimaFunction {

	public LEN() {
		super("LEN");
	}
	
	@Override
	public Value runFunction(Contract zContract) throws ExecutionException {
		checkExactParamNumber(requiredParams());
		
		//The Data
		HexValue hex = zContract.getHexParam(0, this);
		int len      = hex.getRawData().length;
		
		return new NumberValue(len);
	}

	@Override
	public int requiredParams() {
		return 1;
	}
	
	@Override
	public MinimaFunction getNewFunction() {
		return new LEN();
	}
}
