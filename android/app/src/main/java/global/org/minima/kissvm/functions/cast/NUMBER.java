package global.org.minima.kissvm.functions.cast;

import global.org.minima.kissvm.Contract;
import global.org.minima.kissvm.exceptions.ExecutionException;
import global.org.minima.kissvm.functions.MinimaFunction;
import global.org.minima.kissvm.values.BooleanValue;
import global.org.minima.kissvm.values.HexValue;
import global.org.minima.kissvm.values.NumberValue;
import global.org.minima.kissvm.values.StringValue;
import global.org.minima.kissvm.values.Value;
import global.org.minima.objects.base.MiniData;
import global.org.minima.objects.base.MiniNumber;

/**
 * Convert a HEXValue to a NUMBERVALUE
 * 
 * @author spartacusrex
 *
 */
public class NUMBER extends MinimaFunction {

	public NUMBER() {
		super("NUMBER");
	}
	
	@Override
	public Value runFunction(Contract zContract) throws ExecutionException {
		checkExactParamNumber(requiredParams());
		
		//Get the Value..
		Value val = getParameter(0).getValue(zContract);
		
		int type = val.getValueType();
		if(type == Value.VALUE_BOOLEAN) {
			BooleanValue cval = (BooleanValue)val;
			if(cval.isTrue()) {
				return new NumberValue(1);
			}else{
				return new NumberValue(0);
			}
		
		}else if(type == Value.VALUE_HEX) {
			HexValue cval = (HexValue)val;
			MiniData md1 = cval.getMiniData();
			MiniNumber num = new MiniNumber(md1.getDataValue());
			return new NumberValue(num);
	
		}else if(type == Value.VALUE_SCRIPT) {
			StringValue cval = (StringValue)val;
			return new NumberValue(cval.toString());
		
		}else if(type == Value.VALUE_NUMBER) {
			NumberValue cval = (NumberValue)val;
			return new NumberValue(cval.getNumber());
		}
	
		throw new ExecutionException("Invalid Type in NUMBER cast "+type);
	}

	@Override
	public int requiredParams() {
		return 1;
	}
	
	@Override
	public MinimaFunction getNewFunction() {
		return new NUMBER();
	}
}
