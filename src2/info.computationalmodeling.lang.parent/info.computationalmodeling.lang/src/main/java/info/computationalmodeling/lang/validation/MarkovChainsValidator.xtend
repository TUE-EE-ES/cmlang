/*
 * generated by Xtext 2.26.0
 */
package info.computationalmodeling.lang.validation


import java.util.HashSet
import info.computationalmodeling.lang.markovchains.MarkovChainModel
import info.computationalmodeling.lang.markovchains.Probability
import info.computationalmodeling.lang.MarkovChainSupport
import info.computationalmodeling.lang.markovchains.MarkovchainsPackage
import org.eclipse.xtext.validation.Check

/**
 * This class contains custom validation rules. 
 *
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#validation
 */
class MarkovChainsValidator extends AbstractMarkovChainsValidator {



	public static val double PROBMASSMARGIN = 0.001
	
	def checkProbabilityMassTotalOnTransitions(MarkovChainModel m) {
		var result = new HashSet<String>()
		val states = MarkovChainSupport.getStates(m)
		val stateIndex = MarkovChainSupport.createStateIndex(states)
		val P = MarkovChainSupport.transitionProbabilities(m, states, stateIndex) 
		// check all rows
		for (var i = 0; i < states.length; i++) {
			val total = MarkovChainSupport.getRowTotal(P, states.length, i)
			if (total > 1.0 + PROBMASSMARGIN) {
				result.add(states.get(i))
			}
		}
		return result
	}


// check that the probability mass of the initial distribution is equal to one if there is one
	
	public static val INVALID_DISTRIBUTION = 'InvalidDistribution'

	// check that all probabilities specs do not exceed 1
	@Check
	def checkProbabilityValues(Probability p) {
		if (p.int != 0) {
			if (p.int > 1) {
			val String message = 'Probability cannt be larger than one.'
			messageAcceptor.acceptError(message, p, MarkovchainsPackage.Literals.PROBABILITY__INT, -1, INVALID_DISTRIBUTION)
			}
		}
		if (p.float !== null) {
			val prob = Float.parseFloat(p.float)
			if (prob > 1 + PROBMASSMARGIN) {
			val String message = 'Probability cannt be larger than one.'
			messageAcceptor.acceptError(message, p, MarkovchainsPackage.Literals.PROBABILITY__FLOAT, -1, INVALID_DISTRIBUTION)
			}
		}
		if (p.ratio !== null) {
			if (p.ratio.numerator > p.ratio.denominator || p.ratio.denominator==0) {
			val String message = 'Probability is invalid.'
			messageAcceptor.acceptError(message, p, MarkovchainsPackage.Literals.PROBABILITY__RATIO, -1, INVALID_DISTRIBUTION)
			}
		}
	}

	// check that probability mass of the transitions does not exceed 1
	@Check
	def checkProbabilityMassTransitions(MarkovChainModel m) {
		val states = checkProbabilityMassTotalOnTransitions(m)
		val stateMap = MarkovChainSupport.getStatesECoreMap(m)
		for (s: states) {
			val String message = 'Outgoing probabilities of state ' + s + ' exceed 1.'
			messageAcceptor.acceptError(message, stateMap.get(s), MarkovchainsPackage.Literals.STATE__NAME, -1, INVALID_DISTRIBUTION)
		}
	}
	
}
