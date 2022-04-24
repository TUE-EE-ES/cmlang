/*
 * generated by Xtext 2.26.0
 */
package info.computationalmodeling.lang.ide

import com.google.inject.Guice
import info.computationalmodeling.lang.MaxPlusMatrixRuntimeModule
import info.computationalmodeling.lang.MaxPlusMatrixStandaloneSetup
import org.eclipse.xtext.util.Modules2

/**
 * Initialization support for running Xtext languages as language servers.
 */
class MaxPlusMatrixIdeSetup extends MaxPlusMatrixStandaloneSetup {

	override createInjector() {
		Guice.createInjector(Modules2.mixin(new MaxPlusMatrixRuntimeModule, new MaxPlusMatrixIdeModule))
	}
	
}
