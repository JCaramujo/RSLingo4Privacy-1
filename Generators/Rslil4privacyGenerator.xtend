/*
 * generated by Xtext
 */
package org.xtext.example.mydsl.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.IGenerator
import org.eclipse.xtext.generator.IFileSystemAccess
import org.xtext.example.mydsl.rslil4privacy.Policy
import org.xtext.example.mydsl.rslil4privacy.Service
import org.xtext.example.mydsl.rslil4privacy.Recipient
import org.xtext.example.mydsl.rslil4privacy.PrivateData
import org.xtext.example.mydsl.rslil4privacy.ReferToService
import org.xtext.example.mydsl.rslil4privacy.RefPrivateData
import org.xtext.example.mydsl.rslil4privacy.ReferToRecipient
import org.xtext.example.mydsl.rslil4privacy.ReferToRecipientSource
import org.xtext.example.mydsl.rslil4privacy.ReferToRecipientTarget
import org.xtext.example.mydsl.rslil4privacy.Collection
import org.xtext.example.mydsl.rslil4privacy.Disclosure
import org.xtext.example.mydsl.rslil4privacy.Retention
import org.xtext.example.mydsl.rslil4privacy.Usage
import org.xtext.example.mydsl.rslil4privacy.Informative
import org.xtext.example.mydsl.rslil4privacy.Attribute
/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class Rslil4privacyGenerator implements IGenerator {
	
override void doGenerate(Resource resource, IFileSystemAccess fsa) {	
		fsa.generateFile(resource.className+'.EddyPolicy', 		
resource.allContents.filter(typeof(Policy)).map[compilepo].join('

'))}       
//----------------------------------------------------  

def className(Resource res) {
    var name = res.URI.lastSegment
    return name.substring(0, name.indexOf('.'))
    }
//----------------------------------------------------
def compilepo(Policy policy)
'''
SPEC HEADER

    «IF !policy.recipient.empty»«FOR x:policy.recipient»«x.compileActor»«ENDFOR»«ENDIF»
    «IF !policy.service.empty»«FOR z:policy.service»«z.compilepurpose»«ENDFOR»«ENDIF»
    «IF !policy.privateData.empty»«FOR y:policy.privateData»«y.compiledetum»«ENDFOR»«ENDIF»

SPEC POLICY

    «IF !policy.collection.empty»«FOR x:policy.collection»«x.compilecollection»«ENDFOR»«ENDIF»
    «IF !policy.disclosure.empty»«FOR x:policy.disclosure»«x.compiletransfer»«ENDFOR»«ENDIF»
    «IF !policy.retention.empty»«FOR x:policy.retention»«x.compileretention»«ENDFOR»«ENDIF»
    «IF !policy.usage.empty»«FOR x:policy.usage»«x.compileusage»«ENDFOR»«ENDIF»
    «IF !policy.informative.empty»«FOR x:policy.informative»«x.compileinformative»«ENDFOR»«ENDIF»
'''
//---------------------------------------------------- 
def compileActor (Recipient r)
'''
«IF r.partof != null»A «r.partof.recipientname» > «r.recipientname»«ENDIF»
'''
//---------------------------------------------------- 
def compilepurpose (Service se)
'''
«IF se.refprivatedata != null»P «se.description» > «FOR pur:se.refprivatedata SEPARATOR ','»«pur.compilepurpose»«ENDFOR»«ENDIF»
'''
def compilepurpose (RefPrivateData pur)
'''«pur.refpr.privatedata»'''
//---------------------------------------------------- 
def compiledetum (PrivateData pd)
'''
«IF pd.name != null»D «pd.privatedata» > «FOR pdat:pd.attribute SEPARATOR ','»«pdat.compiledetumat»«ENDFOR»«ENDIF»
'''
def compiledetumat (Attribute pdat)
'''«pdat.name»'''
//---------------------------------------------------- 
def compilecollection(Collection coll)
'''
«IF coll.modalitykind== 'Permitted'» P «ELSEIF coll.modalitykind== 'Obligatory'» O «ELSE» R «ENDIF»COLLECT «/*
*/»«FOR p:coll.refprivatedata SEPARATOR','»«p.compilep» «ENDFOR»«/*
*/»«IF !coll.refertoservice.empty»FOR «FOR b:coll.refertoservice SEPARATOR ','»«b.compiles»«ENDFOR»«ELSE»FOR Anything«ENDIF»
'''
//---------------------------------------------------- 
def compiletransfer(Disclosure tran)
'''
«IF tran.modalitykind== 'Permitted'» P «ELSEIF tran.modalitykind== 'Obligatory'» O «ELSE» R «ENDIF»TRANSFER «/*
*/»«FOR p:tran.refprivatedata SEPARATOR','»«p.compilep» «ENDFOR»«/*
*/»«IF !tran.referToRecipientsource.empty»TO «FOR rs:tran.referToRecipientsource SEPARATOR ','»«rs.compiler»«ENDFOR» «ENDIF»«/*
*/»«IF !tran.referToRecipienttarget.empty»FROM «FOR rt:tran.referToRecipienttarget SEPARATOR ','»«rt.compiler»«ENDFOR» «ENDIF»«/*
*/»«IF !tran.refertoservice.empty»FOR «FOR b:tran.refertoservice SEPARATOR ','»«b.compiles»«ENDFOR»«ELSE»FOR Anything«ENDIF»
'''
//---------------------------------------------------- 
def compileretention(Retention ret)
'''
«IF ret.modalitykind== 'Permitted'» P «ELSEIF ret.modalitykind== 'Obligatory'» O «ELSE» R «ENDIF»RETAIN «/*
*/»«FOR p:ret.refprivatedata SEPARATOR','»«p.compilep» «ENDFOR»«/*
*/»«IF !ret.refertoservice.empty»FOR «FOR b:ret.refertoservice SEPARATOR ','»«b.compiles»«ENDFOR»«ELSE»FOR Anything«ENDIF»
'''
//---------------------------------------------------- 
def compileusage(Usage use)
'''
«IF use.modalitykind== 'Permitted'» P «ELSEIF use.modalitykind== 'Obligatory'» O «ELSE» R «ENDIF»USE «/*
*/»«FOR p:use.refprivatedata SEPARATOR','»«p.compilep» «ENDFOR»«/*
*/»«IF !use.refertoservice.empty»FOR «FOR b:use.refertoservice SEPARATOR ','»«b.compiles»«ENDFOR»«ELSE»FOR Anything«ENDIF»
'''
//---------------------------------------------------- 
def compileinformative(Informative inf)
'''
«IF inf.modalitykind== 'Permitted'» P «ELSEIF inf.modalitykind== 'Obligatory'» O «ELSE» R «ENDIF»INFORM «/*
*/»«FOR p:inf.refprivatedata SEPARATOR','»«p.compilep» «ENDFOR»«/*
*/»«IF !inf.refertoservice.empty»FOR «FOR b:inf.refertoservice SEPARATOR ','»«b.compiles»«ENDFOR»«ELSE»FOR Anything«ENDIF»
'''
//----------------------------------------------------
def compiler(ReferToRecipientSource rs) '''«rs.refertore.recipientname»'''
def compiler(ReferToRecipientTarget rt) '''«rt.refertore.recipientname»'''
def compilep(RefPrivateData p) '''«p.refpr.privatedata»'''
def compiles(ReferToService b) '''«b.refertose.description»'''
//---------------------------------------------------- 
}