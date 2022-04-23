/*
 * generated by Xtext 2.19.0
 */
package org.xtext.computationalmodelling.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import org.xtext.computationalmodelling.DataflowRuntimeModule
import com.google.inject.Guice



/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */

class DataflowGenerator extends AbstractGenerator {

    com.google.inject.Injector injector = Guice.createInjector(new DataflowRuntimeModule());
	DataflowGeneratorGraphviz genA = new DataflowGeneratorGraphviz();
	DataflowGeneratorSDF3 genB = new DataflowGeneratorSDF3();

	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {

		// generate both Graphviz and SDF3 files at the same time
		
	    // first Graphviz
	    injector.injectMembers(genA);
		genA.doGenerate(resource, fsa, context);

		// then SDF3
	    injector.injectMembers(genB);
		genB.doGenerate(resource, fsa, context);
	}

}