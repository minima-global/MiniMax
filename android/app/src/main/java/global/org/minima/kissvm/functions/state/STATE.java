package global.org.minima.kissvm.functions.state;

import global.org.minima.kissvm.Contract;
import global.org.minima.kissvm.exceptions.ExecutionException;
import global.org.minima.kissvm.functions.MinimaFunction;
import global.org.minima.kissvm.values.Value;

public class STATE extends MinimaFunction {

	public STATE() {
		super("STATE");
	}
	
	@Override
	public Value runFunction(Contract zContract) throws ExecutionException {
		checkExactParamNumber(requiredParams());
		
		//Which Output
		int statenum = zContract.getNumberParam(0, this).getNumber().getAsInt();

		//Work it out
		return zContract.getState(statenum);
	}

	@Override
	public int requiredParams() {
		return 1;
	}
	
	@Override
	public MinimaFunction getNewFunction() {
		return new STATE();
	}
}
