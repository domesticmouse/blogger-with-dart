#import('dart:html');

class step03Webapp {

  // Map from "Carbon" -> List of Carbon facts
  final Map<String, List<Element>> subjects;

  // Map from "has the Symbol" -> List of has the Symbol facts
  final Map<String, List<Element>> predicates;
  
  // Map from "Colourless" -> List of Colourless facts
  final Map<String, List<Element>> objects;
  
  // List of all valid facts; useful for resetting styles.
  final List<Element> validFacts;
  
  
  step03Webapp() : 
    subjects = {},
    predicates = {},
    objects = {},
    validFacts = []
  {}

  void run() {
    
    var factgroups = document.queryAll(".factgroup");
    for (final Element factgroup in factgroups) {
      
      var facts = factgroup.queryAll(".fact");
      for (final Element fact in facts) {
        Element subject   = fact.query('.subject');
        Element predicate = fact.query('.predicate');
        Element object    = fact.query('.object');
        
        if (subject != null && predicate != null && object != null) {
          validFacts.add(fact);
          
          String subjectText = subject.innerHTML;
          if(!subjects.containsKey(subjectText)) {
            subjects[subjectText] = [];
          }
          subjects[subjectText].add(fact);
          
          String predicateText = predicate.innerHTML;
          if(!predicates.containsKey(predicateText)) {
            predicates[predicateText] = [];
          }
          predicates[predicateText].add(fact);
          
          String objectText = object.innerHTML;
          if(!objects.containsKey(objectText)) {
            objects[objectText] = [];
          }
          objects[objectText].add(fact);
          
          
          fact.on.mouseOver.add((event) {
            
            validFacts.forEach((Element factToClear) {
              factToClear.queryAll('*').forEach((Element part) => part.style.border = "none");
            });
            
            for (final Element factToHighlight in subjects[subjectText]) {
              Element subjectPart = factToHighlight.query(".subject");
              subjectPart.style.border = "solid";
              subjectPart.style.borderRadius = "5px";
              subjectPart.style.borderColor = "#00aa00";
            }
            
            for (final Element factToHighlight in objects[objectText]) {
              Element objectPart = factToHighlight.query(".object");
              objectPart.style.border = "solid";
              objectPart.style.borderRadius = "5px";
              objectPart.style.borderColor = "#00aaaa";
            }
            
            for (final Element factToHighlight in predicates[predicateText]) {
              Element predicatePart = factToHighlight.query(".predicate");
              predicatePart.style.border = "solid";
              predicatePart.style.borderRadius = "5px";
              predicatePart.style.borderColor = "#0099ff";
            }
            
          });
        } 
      }
    }
  }

}

void main() {
  new step03Webapp().run();
}
