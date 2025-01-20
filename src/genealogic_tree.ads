with Binary_Tree;

package Genealogic_Tree is

  -- #----------#
  -- # T_Person #
  -- #----------#

  -- ### Type and Exceptions ###

	type T_Person_Fields is
		record
			ID: Integer;
		end record;

	type T_Person;
	type T_Person is access T_Person_Fields;

	type T_Tab_Person is array (1..100) of T_Person;

  -- ### Constructor ###

	-- Initializes a person
	procedure Init(Person: in out T_Person; ID: in Integer) with
		Post => GetID(Person) = ID;

  -- ### Getters / Setters ###

	-- Returns the id of the person
	function GetID (Person: in T_Person) return Integer;

  -- #-------------------#
  -- # T_Genealogic_Tree #
  -- #-------------------#

  -- ### Type and Exceptions ###

	package Genealogic_Tree_Of_Persons is
	  new Binary_Tree (T_Data => T_Person);
	use Genealogic_Tree_Of_Persons;

	subtype T_Genealogic_Tree is Genealogic_Tree_Of_Persons.T_Tree;
  function GetLeft (Tree: T_Genealogic_Tree) return T_Genealogic_Tree renames Genealogic_Tree_Of_Persons.GetLeft;
  function GetRight (Tree: T_Genealogic_Tree) return T_Genealogic_Tree renames Genealogic_Tree_Of_Persons.GetRight;
	function GetData (Tree: in T_Genealogic_Tree) return T_Person renames Genealogic_Tree_Of_Persons.GetData; 


  -- ### Functions ###

	-- Add parent
	procedure AddParent(Tree: in out T_Genealogic_Tree; Person: in T_Person; IsFemale: in Boolean) with
		Post => ((IsFemale = False) and (GetID(GetData(GetLeft(Tree))) = GetID(Person))) or (IsFemale and (GetID(GetData(GetRight(Tree))) = GetID(Person))); -- Si on ajoute une mere, on vérifie l'ID de la personne de droite et si on ajoute un pere, l'ID de gauche

	-- Delete persons of the tree
	procedure DeletePerson(Tree: in out T_Genealogic_Tree; Person: in T_Person) with
		Pre => (FindInTree(Tree, GetID(Person)) = True),
		Post => (FindInTree(Tree, GetID(Person)) = False); -- L'arbre en entrée doit être différent de celui en sortie. La personne renseignée ne doit plus être dans l'arbre

	-- Returns the number of ancestors of the person
	function NumberAncestors(Tree: in T_Genealogic_Tree; Person: in T_Person) return Integer with
		Pre => (FindInTree(Tree, GetID(Person)) = True), -- La personne renseignée doit être dans l'arbre fourni
		Post => (NumberAncestors'Result >= 1); -- Le nombre d'ancêtres doit être de 1 minimum car la personne renseignée est compris dans les ancêtres

	-- Returns all the ID of the ancestors of the person
	function AncestorsGen(Tree: in T_Genealogic_Tree; Person: in T_Person; Generation: in Integer) return T_Tab_Person with
		Pre => (FindInTree(Tree, GetID(Person)) = True);

	-- Print the tree
	procedure PrintTree(Tree: in T_Genealogic_Tree);

	-- Returns the persons who don't have parents
	function PersonsWithXParents(Tree: in T_Genealogic_Tree; NumberParent: in Integer) return T_Tab_Person with
		Pre => ((NumberParent >= 0) and (NumberParent <= 2));

	-- Determinates if the person is in tree
	function FindInTree(Tree: in T_Genealogic_Tree; ID: Integer) return Boolean;

end Genealogic_Tree;
