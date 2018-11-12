// IntegerVector seqBoot_index(long sLen, IntegerMatrix indMat) {
//   IntegerVector y(sLen, -1), c_t;
//   long rows = indMat.nrow(), i, j, cols = indMat.ncol();
//   NumericVector ubar_i;
//   NumericMatrix u_ti;
//   IntegerMatrix indMat2(rows, cols+1);
//   y[0] = rand() % cols;
//   for(i = 0; i < indMat2.nrow(); i++) {
//     for(j = 0; j < cols; j++) {
//       indMat2(i, j) = indMat(i, j);
//     }
//     indMat2(i, cols) = indMat(i, y[0]);
//   }
//   c_t = indMat(_, y[0]);
//   for(i = 1; i < sLen; i++) {
//     if(i != 1) {
//       c_t = calculate_c_t(indMat2);
//     }
//     u_ti = calculate_u_ti(indMat2, c_t, rows, sLen, i);
//     ubar_i = calculate_ubar_i(u_ti, indMat2);
//     y[i] = sample_with_p(ubar_i, cols);
//     for(j = 0; j < rows; j++) {
//       indMat2(j, i) = indMat(j, y[i]);
//     }
//   }
//   return(y);
// }
// 

// 
// NumericMatrix seqBoot(NumericMatrix features, int seed = -1) {
//   if(seed != -1) {
//     srand(seed);
//   }
//   return(features);
// }

// IntegerVector calculate_c_t(IntegerMatrix indMat2) {
//   IntegerVector c_t = rowSumsC(indMat2);
//   return(c_t);
// }
// 
// NumericMatrix calculate_u_ti(IntegerMatrix indMat2, IntegerVector c_t,
//                              long rows, long sLen, long i) {
//   NumericMatrix u_ti(rows, sLen);
//   for(long j = 0; j < i; j++) {
//     for(long k = 0; k < u_ti.ncol(); k++) {
//       u_ti(j, k) = indMat2(j, k)/float(c_t[j] + 1);
//       // I don't understand. Why c_t + 1?
//     }
//   }
//   return(u_ti);
// }

// NumericVector calculate_ubar_i(NumericMatrix u_ti, IntegerMatrix indMat2) {
//   NumericVector ubar_i, cs;
//   ubar_i = colSumsC(u_ti);
//   long j;
//   cs = colSumsC(indMat2);
//   printf("%ld\n", cs.length());
//   for(j = 0; j < cs.length(); j++) {
//     printf("%lf,", cs[j]);
//   }
//   printf("\n");
//   double total = 0;
//   for(j = 0; j < ubar_i.length(); j++) {
//     if(cs[j] != 0) {
//       ubar_i[j] = ubar_i[j]/float(cs[j]);
//       total += ubar_i[j];
//     }
//   }
//   for(j = 0; j < ubar_i.length(); j++) {
//     ubar_i[j] /= total;
//   }
//   return(ubar_i);
// }

// NumericVector colSumsC(NumericMatrix x) {
//   long nrow = x.nrow(), ncol = x.ncol();
//   NumericVector out(ncol, 0);
//   
//   for (long i = 0; i < ncol; i++) {
//     for (long j = 0; j < nrow; j++) {
//       out[i] += x(j, i);
//     }
//   }
//   return(out);
// }
// 
// NumericVector colSumsC(IntegerMatrix x) {
//   long nrow = x.nrow(), ncol = x.ncol();
//   NumericVector out(ncol, 0);
//   
//   for (long i = 0; i < ncol; i++) {
//     for (long j = 0; j < nrow; j++) {
//       out[i] += x(j, i);
//     }
//   }
//   return(out);
// }