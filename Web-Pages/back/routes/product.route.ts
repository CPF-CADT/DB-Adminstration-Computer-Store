import { getAllProduct,getOneProduct,getProductDetail,addProductFeedback,addNewProduct } from '../controller/product.controller';
import express from 'express'
import JWT from '../service/JWT';
const productRouter = express.Router();
productRouter.get('/',getAllProduct)
productRouter.post('/', addNewProduct);
productRouter.get('/:product_code',getOneProduct)
productRouter.get('/:product_code/detail',getProductDetail)
productRouter.post('/:product_code/feedback',JWT.verify,addProductFeedback)

export default productRouter;   
