import {User} from "./User";
import {Image} from "./Image";
import {Recipe} from "./Recipe";

export class Cocktail{
  cocktailId: number;
  cocktailName: string;
  cocktailAuthor: User;
  cocktailRating: number;
  publicationDate: Date;
  cocktailImage: Image;
  cocktailRecipe: string;
  approxAlcoholPercentage: number;
  recipes: Recipe[];


  constructor(cocktailId?: number, cocktailName?: string, cocktailAuthor?: User, cocktailRating?: number,
              publicationDate?: Date, cocktailImage?: Image, cocktailRecipe?: string,
              approxAlcoholPercentage?: number, recipes?: Recipe[]) {
    this.cocktailId = cocktailId;
    this.cocktailName = cocktailName;
    this.cocktailAuthor = cocktailAuthor;
    this.cocktailRating = cocktailRating;
    this.publicationDate = publicationDate;
    this.cocktailImage = cocktailImage;
    this.cocktailRecipe = cocktailRecipe;
    this.approxAlcoholPercentage = approxAlcoholPercentage;
    this.recipes = recipes;
  }
}
