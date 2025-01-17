package Genealogic_Tree is

  -- #----------#
  -- # T_Person #
  -- #----------#

  -- ### Type and Exceptions ###

	type T_Person is limited private;

  -- ### Constructor ###

	-- Initializes a person
	procedure Init(Person: in out T_Person; ID: in Integer) with
		Post => GetID(Person) = ID;

	-- Add parent
	procedure AddParent(Tree: in out T_Genealogic_Tree; Person: in T_Person; IsFemale: in Boolean; IDParent: in Integer) with
		Post => ((IsFemale = False) and (GetID(GetLeft(T_Person)) = IDParent)) or ((IsFemale = True) and (GetID(GetRight(T_Person)) = IDParent)); -- Si on ajoute une mere, on vérifie l'ID de la personne de droite et si on ajoute un pere, l'ID de gauche

	-- Delete persons of the tree
	procedure DeletePerson(Tree: in out T_Genealogic_Tree; Person: in T_Person) with
		Pre => (Person in Tree),
		Post => (Tree'Old /= Tree'New) and (not(Person in Tree'New)); -- L'arbre en entrée doit être différent de celui en sortie. La personne renseignée ne doit plus être dans l'arbre

  -- ### Getters / Setters ###

	-- Returns the id of the person
	function GetID (Person: in T_Person) return Integer;

	-- Returns the number of ancestors of the person
	function NumberAncestors(Tree: in T_Genealogic_Tree; Person: in T_Person) return Integer with
		Pre => (Person in Tree), -- La personne renseignée doit être dans l'arbre fourni
		Post => (NumberAncestors'Result >= 1); -- Le nombre d'ancêtres doit être de 1 minimum car la personne renseignée est compris dans les ancêtres

	-- Returns all the ID of the ancestors of the person
	function AncestorsGen(Tree: in T_Genealogic_Tree; Person: in T_Person; Generation: in Integer) return T_Tab_Person with
		Pre => (Person in Tree);

	-- Print the tree
	procedure PrintTree(Tree: in T_Genealogic_Tree);

	-- Returns the persons who don't have parents
	function PersonsWithXParents(Tree: in T_Genealogic_Tree; NumberParent: in Integer) return T_Tab_Person with
		Pre => ((NumberParent >= 0) and (NumberParent <= 2));

  -- #-------------------#
  -- # T_Genealogic_Tree #
  -- #-------------------#

  -- ### Type and Exceptions ###

	package Genealogic_Tree_Of_Persons is
	  new Binary_Tree (T_Data => T_Person);
	use Genealogic_Tree_Of_Persons;

	subtype T_Genealogic_Tree is Genealogic_Tree_Of_Persons.T_Tree;

  -- ### Functions ###

  private

	type T_Person_Fields;
	type T_Person is access T_Person_Fields;
	type T_Person_Fields is
		record
			ID: Integer;
		end record;
	type T_Tab_Person is array (1..100) of T_Person;

end Genealogic_Tree;
