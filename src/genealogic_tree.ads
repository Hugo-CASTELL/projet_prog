with Binary_Tree;
with List;

package Genealogic_Tree is

  -- #----------#
  -- # T_Person #
  -- #----------#

  -- ### Type and Exceptions ###

	type T_Person_Fields is
		record
			ID: Natural;
		end record;

	type T_Person;
	type T_Person is access T_Person_Fields;

	package List_Persons is
	  new List (T_Type => T_Person, Capacity => 100);
	use List_Persons;
	type T_List_Person is new List_Persons.T_List with null record;

  -- ### Constructor ###

	-- Initializes a person
	procedure Init(Person: in out T_Person; ID: in Natural) with
		Post => GetID(Person) = ID;

  -- ### Getters / Setters ###

	-- Returns the id of the person
	function GetID (Person: in T_Person) return Natural;

  -- #-------------------#
  -- # T_Genealogic_Tree #
  -- #-------------------#

  -- ### Type and Exceptions ###

	package Genealogic_Tree_Of_Persons is
	  new Binary_Tree (T_Data => T_Person);
	use Genealogic_Tree_Of_Persons;

	subtype T_Genealogic_Tree is Genealogic_Tree_Of_Persons.T_Tree;

	package List_Genealogic_Tree is
	  new List (T_Type => T_Genealogic_Tree, Capacity => 100);
	use List_Genealogic_Tree;
	type T_List_Genealogic_Tree is new List_Genealogic_Tree.T_List with null record;

	procedure Init(Tree: in out T_Genealogic_Tree; Data: in T_Person) renames Genealogic_Tree_Of_Persons.Init;
  function GetLeft (Tree: T_Genealogic_Tree) return T_Genealogic_Tree renames Genealogic_Tree_Of_Persons.GetLeft;
	procedure SetLeft (Tree: in out T_Genealogic_Tree ; Data: in T_Person) renames Genealogic_Tree_Of_Persons.SetLeft;
	procedure ClearLeft (Tree: in out T_Genealogic_Tree) renames Genealogic_Tree_Of_Persons.ClearLeft;
  function GetRight (Tree: T_Genealogic_Tree) return T_Genealogic_Tree renames Genealogic_Tree_Of_Persons.GetRight;
	procedure SetRight (Tree: in out T_Genealogic_Tree; Data: in T_Person) renames Genealogic_Tree_Of_Persons.SetRight;
	procedure ClearRight (Tree: in out T_Genealogic_Tree) renames Genealogic_Tree_Of_Persons.ClearRight;
	function GetData (Tree: in T_Genealogic_Tree) return T_Person renames Genealogic_Tree_Of_Persons.GetData; 
	function IsBranchEmpty (Tree: in T_Genealogic_Tree ; left: in Boolean) return Boolean renames Genealogic_Tree_Of_Persons.IsBranchEmpty;
	function IsLeaf (Tree: in T_Genealogic_Tree) return Boolean renames Genealogic_Tree_Of_Persons.IsLeaf;
	function IsEmpty (Tree: in T_Genealogic_Tree) return Boolean renames Genealogic_Tree_Of_Persons.IsEmpty;
	function GetSize (Tree: in T_Genealogic_Tree) return Natural renames Genealogic_Tree_Of_Persons.GetSize;
	procedure Print (Tree: in T_Genealogic_Tree) renames Genealogic_Tree_Of_Persons.Print;
	procedure Delete (Tree: in out T_Genealogic_Tree) renames Genealogic_Tree_Of_Persons.Delete;

  -- ### Functions ###

	-- Add parent
	procedure AddParentByPerson(Tree: in out T_Genealogic_Tree; Person: in T_Person; IsFemale: in Boolean) with
		 Post => ((IsFemale = False)  and (IsBranchEmpty(Tree, True)  = False)) or 
             (IsFemale           and (IsBranchEmpty(Tree, False) = False)); -- Si on ajoute une mere, on vérifie l'ID de la personne de droite et si on ajoute un pere, l'ID de gauche
	procedure AddParentById(Tree: in out T_Genealogic_Tree; ID_Person: in Natural; IsFemale: in Boolean) with
		 Post => ((IsFemale = False)  and (IsBranchEmpty(Tree, True)  = False)) or 
             (IsFemale            and (IsBranchEmpty(Tree, False) = False)); 

	-- Delete persons of the tree
	procedure DeletePerson(Tree: in out T_Genealogic_Tree; Person: in T_Person) with
		Pre => (FindInTree(Tree, GetID(Person)) = True),
		Post => (FindInTree(Tree, GetID(Person)) = False); -- L'arbre en entrée doit être différent de celui en sortie. La personne renseignée ne doit plus être dans l'arbre

	-- Returns the number of ancestors of the person
	function NumberAncestors(Tree: in T_Genealogic_Tree; Person: in T_Person) return Natural with
		Pre => (FindInTree(Tree, GetID(Person)) = True), -- La personne renseignée doit être dans l'arbre fourni
		Post => (NumberAncestors'Result >= 1); -- Le nombre d'ancêtres doit être de 1 minimum car la personne renseignée est compris dans les ancêtres

	-- Returns all the ID of the ancestors of the person
	function AncestorsGen(Tree: in T_Genealogic_Tree; Person: in T_Person; Generation: in Natural) return T_List_Person with
		Pre => (FindInTree(Tree, GetID(Person)) = True);

	-- Print the tree
	procedure PrintTree(Tree: in T_Genealogic_Tree);

	-- Returns the persons who don't have parents
	function PersonsWithXParents(Tree: in T_Genealogic_Tree; NumberParent: in Natural) return T_List_Person with
		Pre => ((NumberParent >= 0) and (NumberParent <= 2));

	-- Determinates if the person is in tree
	function FindInTree(Tree: in T_Genealogic_Tree; ID: Natural) return Boolean;
  
end Genealogic_Tree;
