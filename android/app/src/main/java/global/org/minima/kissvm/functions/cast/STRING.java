package global.org.minima.kissvm.functions.cast;

import global.org.minima.kissvm.Contract;
import global.org.minima.kissvm.exceptions.ExecutionException;
import global.org.minima.kissvm.functions.MinimaFunction;
import global.org.minima.kissvm.values.StringValue;
import global.org.minima.kissvm.values.Value;

public class STRING extends MinimaFunction {

	public STRING() {
		super("STRING");
	}
	
	@Override
	public Value runFunction(Contract zContract) throws ExecutionException {
		checkExactParamNumber(requiredParams());
		
		Value val = getParameter(0).getValue(zContract);
		
		return new StringValue(val.toString());
	}

	@Override
	public int requiredParams() {
		return 1;
	}
	
	@Override
	public MinimaFunction getNewFunction() {
		return new STRING();
	}
}
