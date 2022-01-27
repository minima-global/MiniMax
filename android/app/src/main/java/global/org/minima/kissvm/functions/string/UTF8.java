package global.org.minima.kissvm.functions.string;

import global.org.minima.kissvm.Contract;
import global.org.minima.kissvm.exceptions.ExecutionException;
import global.org.minima.kissvm.functions.MinimaFunction;
import global.org.minima.kissvm.values.HexValue;
import global.org.minima.kissvm.values.StringValue;
import global.org.minima.kissvm.values.Value;
import global.org.minima.objects.base.MiniString;

/**
 * Replace ALL occurrences of str with replacemnet
 * 
 * @author spartacusrex
 */
public class UTF8 extends MinimaFunction {

	public UTF8() {
		super("UTF8");
	}

	@Override
	public Value runFunction(Contract zContract) throws ExecutionException {
		checkExactParamNumber(requiredParams());
		
		//Get the HEX value
		HexValue hex = zContract.getHexParam(0, this);
		
		//Now create a UTF8 String
		String newstr = new String(hex.getRawData(), MiniString.MINIMA_CHARSET);
		
		return new StringValue(newstr);	
	}
	
	@Override
	public int requiredParams() {
		return 1;
	}
	
	@Override
	public MinimaFunction getNewFunction() {
		return new UTF8();
	}
}
