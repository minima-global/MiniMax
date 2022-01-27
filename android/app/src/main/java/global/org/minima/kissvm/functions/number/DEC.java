package global.org.minima.kissvm.functions.number;

import global.org.minima.kissvm.Contract;
import global.org.minima.kissvm.exceptions.ExecutionException;
import global.org.minima.kissvm.functions.MinimaFunction;
import global.org.minima.kissvm.values.NumberValue;
import global.org.minima.kissvm.values.Value;

public class DEC extends MinimaFunction {

	public DEC() {
		super("DEC");
	}
	
	@Override
	public Value runFunction(Contract zContract) throws ExecutionException {
		checkExactParamNumber(requiredParams());
		
		NumberValue number = zContract.getNumberParam(0, this);
		
		return new NumberValue(number.getNumber().decrement());
	}
	
	@Override
	public int requiredParams() {
		return 1;
	}
	
	@Override
	public MinimaFunction getNewFunction() {
		return new DEC();
	}
}
