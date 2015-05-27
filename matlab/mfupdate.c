static char mc_version[] = "MATLAB Compiler 1.0 infun";
/*
 *  MATLAB Compiler: 1.0
 *  Date: Oct 20, 1995
 *  Arguments: -eir mfupdate 
 */
#include <math.h>
#include "matrix.h"
#include "mcc.h"
#include "matlab.h"

/* static array S0_ (1 x 77) text, line 169 */
static double S0r_[] =
{
	77, 97, 120, 105, 109, 117, 109, 32, 
	105, 116, 101, 114, 97, 116, 105, 111, 
	110, 115, 32, 114, 101, 97, 99, 104, 
	101, 100, 32, 105, 110, 32, 109, 109, 
	102, 117, 112, 100, 97, 116, 101, 92, 
	110, 108, 97, 115, 116, 32, 99, 104, 
	97, 110, 103, 101, 32, 37, 50, 46, 
	50, 102, 92, 116, 116, 111, 108, 101, 
	114, 97, 110, 99, 101, 32, 37, 50, 
	46, 50, 102, 92, 110, 
};
static Matrix S0_ = { {0}, mxFULL, mxDOUBLE, mxSTRING, 0, 1, 77, S0r_, 0, -1, 0, {0} };
/* static array S1_ (1 x 33) text, line 77: 'lltrack\tlltkold\tlltol\t...' */
static double S1__r_[] =
{
        108,  108,  116,  114,   97,   99,  107,   92,
        116,  108,  108,  116,  107,  111,  108,  100,
         92,  116,  108,  108,  116,  111,  108,   92,
        116,  108,  108,  100,  105,  102,  102,   92,
        110,
};
static Matrix S1_ = { {0}, mxFULL, mxDOUBLE, mxSTRING, 0,
        1, 33, S1__r_, 0, -1, 0, {0} };
/* static array S2_ (1 x 6) text, line 91: 'tosser' */
static double S2__r_[] =
{
        116,  111,  115,  115,  101,  114,
};
static Matrix S2_ = { {0}, mxFULL, mxDOUBLE, mxSTRING, 0,
        1, 6, S2__r_, 0, -1, 0, {0} };
/* static array S3_ (1 x 28) text, line 160: '%3.2f\t%3.2f\t%2.3f\t%2.3...' */
static double S3__r_[] =
{
         37,   51,   46,   50,  102,   92,  116,   37,
         51,   46,   50,  102,   92,  116,   37,   50,
         46,   51,  102,   92,  116,   37,   50,   46,
         51,  102,   92,  110,
};
static Matrix S3_ = { {0}, mxFULL, mxDOUBLE, mxSTRING, 0,
        1, 28, S3__r_, 0, -1, 0, {0} };

Matrix *
mlfMfupdate(Matrix **counter_lhs_, Matrix *w_rhs_, Matrix *nd_rhs_, Matrix *v_rhs_, Matrix *options_rhs_)
{
   int ci_, i_, j_;
   unsigned flags_;
   Matrix *Mplhs_[32], *Mprhs_[32];
   int nlhs_=1, nrhs_=0;
   Matrix *vo_lhs_;
   if (counter_lhs_) ++nlhs_;
   if (w_rhs_)
   {
      ++nrhs_;
   }
   if (nd_rhs_)
   {
      ++nrhs_;
   }
   if (v_rhs_)
   {
      ++nrhs_;
   }
   if (options_rhs_)
   {
      ++nrhs_;
   }
   {
/***************** Compiler Assumptions ****************
 *
 *       I0_         	integer scalar temporary
 *       JA          	real vector/matrix
 *       JAt         	real vector/matrix
 *       JB          	real vector/matrix
 *       JBt         	real vector/matrix
 *       K_ji        	real vector/matrix
 *       R0_         	real scalar temporary
 *       R1_         	real scalar temporary
 *       RC0_        	real scalar or char temporary
 *       RM0_        	real vector/matrix temporary
 *       RM10_       	real vector/matrix temporary
 *       RM11_       	real vector/matrix temporary
 *       RM12_       	real vector/matrix temporary
 *       RM13_       	real vector/matrix temporary
 *       RM1_        	real vector/matrix temporary
 *       RM2_        	real vector/matrix temporary
 *       RM3_        	real vector/matrix temporary
 *       RM4_        	real vector/matrix temporary
 *       RM5_        	real vector/matrix temporary
 *       RM6_        	real vector/matrix temporary
 *       RM7_        	real vector/matrix temporary
 *       RM8_        	real vector/matrix temporary
 *       RM9_        	real vector/matrix temporary
 *       S0_         	<constant>
 *       abs         	<function>
 *       blfll       	<function>
 *       counter     	integer scalar
 *       display     	real scalar
 *       exp         	<function>
 *       fprintf     	<function>
 *       h1          	real vector/matrix
 *       h2          	real vector/matrix
 *       h3          	real vector/matrix
 *       i           	integer scalar
 *       index       	integer scalar
 *       linemintol  	real scalar
 *       lldiff      	real vector/matrix
 *       lltol       	real vector/matrix
 *       lltrack     	real vector/matrix
 *       lltrackold  	real vector/matrix
 *       mark1       	integer scalar
 *       mark2       	integer scalar
 *       mark3       	integer scalar
 *       mark4       	integer scalar
 *       mark5       	integer scalar
 *       mark6       	integer scalar
 *       maxiter     	real scalar
 *       mlfMfupdate 	<function being defined>
 *       minline     	<function>
 *       mu1         	real vector/matrix
 *       mu1m        	real vector/matrix
 *       mu2         	real vector/matrix
 *       mu2m        	real vector/matrix
 *       mu3         	real vector/matrix
 *       nargin      	<function>
 *       nd          	real vector/matrix
 *       nrow1       	integer scalar
 *       nrow2       	integer scalar
 *       nrow3       	integer scalar
 *       ones        	<function>
 *       options     	real vector/matrix
 *       percoflll   	real scalar
 *       phi2        	real vector/matrix
 *       phi2m       	real vector/matrix
 *       phi3        	real vector/matrix
 *       phi3m       	real vector/matrix
 *       prod        	<function>
 *       size        	<function>
 *       sum         	<function>
 *       tosser      	global real vector/matrix
 *       v           	real vector/matrix
 *       vo          	real vector/matrix
 *       vold        	real vector/matrix
 *       w           	real vector/matrix
 *       xi1         	real vector/matrix
 *       xi2         	real vector/matrix
 *       xi2m        	real vector/matrix
 *       xi3         	real vector/matrix
 *       xi3m        	real vector/matrix
 *       zeros       	<function>
 *******************************************************/
      Matrix vo;
      int counter;
      Matrix w;
      Matrix nd;
      Matrix v;
      Matrix options;
      int nrow1;
      int nrow2;
      int nrow3;
      double maxiter;
      double linemintol;
      double percoflll;
      double display;
      int mark1;
      Matrix h1;
      int mark2;
      Matrix JA;
      int mark3;
      Matrix h2;
      int mark4;
      Matrix JB;
      int mark5;
      Matrix h3;
      Matrix JAt;
      Matrix JBt;
      Matrix lltrack;
      Matrix lltol;
      Matrix lldiff;
      Matrix xi1;
      Matrix mu1;
      Matrix xi2;
      Matrix mu2;
      Matrix xi3;
      int mark6;
      Matrix mu3;
      Matrix vold;
      int i;
      Matrix tosser;
      Matrix xi3m;
      int index;
      Matrix mu2m;
      Matrix phi3;
      Matrix phi3m;
      Matrix K_ji;
      Matrix xi2m;
      Matrix mu1m;
      Matrix phi2;
      Matrix phi2m;
      Matrix lltrackold;
      Matrix RM0_;
      int I0_;
      double RC0_;
      int RC0__set_ = 0;
      Matrix RM1_;
      Matrix RM2_;
      Matrix RM3_;
      Matrix RM4_;
      Matrix RM5_;
      Matrix RM6_;
      Matrix RM7_;
      Matrix RM8_;
      Matrix RM9_;
      Matrix RM10_;
      Matrix RM11_;
      Matrix RM12_;
      Matrix RM13_;
      double R0_;
      double R1_;
      
      mccRealInit(w);
      mccImport(&w, w_rhs_, 0, 0);
      mccRealInit(nd);
      mccImport(&nd, nd_rhs_, 0, 0);
      mccRealInit(v);
      mccImport(&v, v_rhs_, 0, 0);
      mccRealInit(options);
      mccImport(&options, options_rhs_, 0, 0);
      mccRealInit(vo);
      mccRealInit(h1);
      mccRealInit(JA);
      mccRealInit(h2);
      mccRealInit(JB);
      mccRealInit(h3);
      mccRealInit(JAt);
      mccRealInit(JBt);
      mccRealInit(lltrack);
      mccRealInit(lltol);
      mccRealInit(lldiff);
      mccRealInit(xi1);
      mccRealInit(mu1);
      mccRealInit(xi2);
      mccRealInit(mu2);
      mccRealInit(xi3);
      mccRealInit(mu3);
      mccRealInit(vold);
      mccRealInit(tosser);
      mccRealInit(xi3m);
      mccRealInit(mu2m);
      mccRealInit(phi3);
      mccRealInit(phi3m);
      mccRealInit(K_ji);
      mccRealInit(xi2m);
      mccRealInit(mu1m);
      mccRealInit(phi2);
      mccRealInit(phi2m);
      mccRealInit(lltrackold);
      mccRealInit(RM0_);
      mccRealInit(RM1_);
      mccRealInit(RM2_);
      mccRealInit(RM3_);
      mccRealInit(RM4_);
      mccRealInit(RM5_);
      mccRealInit(RM6_);
      mccRealInit(RM7_);
      mccRealInit(RM8_);
      mccRealInit(RM9_);
      mccRealInit(RM10_);
      mccRealInit(RM11_);
      mccRealInit(RM12_);
      mccRealInit(RM13_);
      
      
      /* % MFUPDATE Update for mean field parameters designed for running as MEX */
      
      /* % Description */
      /* % vo=mfupdate(w, nd, v, options) this function updates all the mean */
      /* % field parameters returing a new vector v. It is being written to */
      /* % compile into a mex file and is therefore not as easy to read as */
      /* % would be preffered. */
      
      /* % See Also */
      /* % blf, blffwd, blfll, blfpak, blfunpak, blfxiopt, blfxill */
      
      
      /* % Copyright (c) Neil D Lawrence (1997) */
      
      /* global tosser */
      /* GLOBAL */
      /* global pussywart */
      /* GLOBAL */
      /* global dickweed */
      /* GLOBAL */
      /* global fartface */
      /* GLOBAL */
      
      /* vo=v; */
      mccCopy(&vo, &v);
      /* nrow1=nd(1); */
      nrow1 = ((int)nd.pr[(1-1)]);
      /* nrow2=nd(2); */
      nrow2 = ((int)nd.pr[(2-1)]);
      /* nrow3=nd(3); */
      nrow3 = ((int)nd.pr[(3-1)]);
      
      /* if nargin==3 */
      if ((mccNargin() == 3))
      {
         /* maxiter=10; 				% Maximum passes through algotrithm */
         maxiter = 10;
         /* linemintol=0.01; 			% tolerance criteria in linemin */
         linemintol = 0.01;
         /* percoflll=0.01; 			% % change in lll for stop */
         percoflll = 0.01;
         /* display=0; */
         display = 0;
         /* elseif nargin==4 */
      }
      else
      {
         if ((mccNargin() == 4))
         {
            /* maxiter=options(14); */
            maxiter = (options.pr[(14-1)]);
            /* percoflll=options(3); */
            percoflll = (options.pr[(3-1)]);
            /* linemintol=options(4); */
            linemintol = (options.pr[(4-1)]);
            /* display=options(1); */
            display = (options.pr[(1-1)]);
            /* end */
         }
      }
      
      /* mark1 = nrow1; */
      mark1 = nrow1;
      /* h1 = w(1:mark1); */
      {
         int m_=1, n_=1, cx_ = 0;
         double t_;
         double *p_h1;
         int I_h1=1;
         double *p_w;
         int I_w=1;
         m_ = mccCalcSubscriptDimensions(m_, &n_, 1, ((int)(mark1 - 1) + 1), &w);
         mccAllocateMatrix(&h1, m_, n_);
         I_h1 = (h1.m != 1 || h1.n != 1);
         p_h1 = h1.pr;
         I_w = (w.m != 1 || w.n != 1);
         p_w = w.pr + ((int)(1 - .5));
         for (j_=0; j_<n_; ++j_)
         {
            for (i_=0; i_<m_; ++i_, p_h1+=I_h1, p_w+=I_w)
            {
               *p_h1 = *p_w;
               ;
            }
         }
      }
      h1.dmode = mxNUMBER;
      /* mark2 = mark1 + nrow1*nrow2; */
      mark2 = (mark1 + (nrow1 * nrow2));
      /* JA = zeros(nrow2, nrow1); */
      mccZerosMN(&JA, nrow2, nrow1);
      /* JA(:) = w(mark1 + 1: mark2); */
      {
         int m_=1, n_=1, cx_ = 0;
         double t_;
         double *p_JA;
         int I_JA=1;
         double *p_w;
         int I_w=1;
         m_ = mccCalcSubscriptDimensions(m_, &n_, 1, ((int)(mark2 - (mark1 + 1)) + 1), &w);
         mccColonOnLhs(&JA, m_*n_);
         I_JA = (JA.m != 1 || JA.n != 1);
         p_JA = JA.pr + 0;
         I_w = (w.m != 1 || w.n != 1);
         p_w = w.pr + ((int)((mark1 + 1) - .5));
         for (j_=0; j_<n_; ++j_)
         {
            for (i_=0; i_<m_; ++i_, p_JA+=I_JA, p_w+=I_w)
            {
               *p_JA = *p_w;
               ;
            }
         }
      }
      JA.dmode = mxNUMBER;
      /* mark3 = mark2 + nrow2; */
      mark3 = (mark2 + nrow2);
      /* h2 = w(mark2 + 1: mark3); */
      {
         int m_=1, n_=1, cx_ = 0;
         double t_;
         double *p_h2;
         int I_h2=1;
         double *p_w;
         int I_w=1;
         m_ = mccCalcSubscriptDimensions(m_, &n_, 1, ((int)(mark3 - (mark2 + 1)) + 1), &w);
         mccAllocateMatrix(&h2, m_, n_);
         I_h2 = (h2.m != 1 || h2.n != 1);
         p_h2 = h2.pr;
         I_w = (w.m != 1 || w.n != 1);
         p_w = w.pr + ((int)((mark2 + 1) - .5));
         for (j_=0; j_<n_; ++j_)
         {
            for (i_=0; i_<m_; ++i_, p_h2+=I_h2, p_w+=I_w)
            {
               *p_h2 = *p_w;
               ;
            }
         }
      }
      h2.dmode = mxNUMBER;
      /* mark4 = mark3 + nrow2*nrow3; */
      mark4 = (mark3 + (nrow2 * nrow3));
      /* JB = zeros(nrow3, nrow2); */
      mccZerosMN(&JB, nrow3, nrow2);
      /* JB(:) = w(mark3 + 1: mark4); */
      {
         int m_=1, n_=1, cx_ = 0;
         double t_;
         double *p_JB;
         int I_JB=1;
         double *p_w;
         int I_w=1;
         m_ = mccCalcSubscriptDimensions(m_, &n_, 1, ((int)(mark4 - (mark3 + 1)) + 1), &w);
         mccColonOnLhs(&JB, m_*n_);
         I_JB = (JB.m != 1 || JB.n != 1);
         p_JB = JB.pr + 0;
         I_w = (w.m != 1 || w.n != 1);
         p_w = w.pr + ((int)((mark3 + 1) - .5));
         for (j_=0; j_<n_; ++j_)
         {
            for (i_=0; i_<m_; ++i_, p_JB+=I_JB, p_w+=I_w)
            {
               *p_JB = *p_w;
               ;
            }
         }
      }
      JB.dmode = mxNUMBER;
      /* mark5 = mark4 + nrow3; */
      mark5 = (mark4 + nrow3);
      /* h3 = w(mark4 + 1: mark5); */
      {
         int m_=1, n_=1, cx_ = 0;
         double t_;
         double *p_h3;
         int I_h3=1;
         double *p_w;
         int I_w=1;
         m_ = mccCalcSubscriptDimensions(m_, &n_, 1, ((int)(mark5 - (mark4 + 1)) + 1), &w);
         mccAllocateMatrix(&h3, m_, n_);
         I_h3 = (h3.m != 1 || h3.n != 1);
         p_h3 = h3.pr;
         I_w = (w.m != 1 || w.n != 1);
         p_w = w.pr + ((int)((mark4 + 1) - .5));
         for (j_=0; j_<n_; ++j_)
         {
            for (i_=0; i_<m_; ++i_, p_h3+=I_h3, p_w+=I_w)
            {
               *p_h3 = *p_w;
               ;
            }
         }
      }
      h3.dmode = mxNUMBER;
      /* mark1 = nrow1; */
      mark1 = nrow1;
      /* JAt=JA'; */
      mccConjTrans(&JAt, &JA);
      /* JBt=JB'; */
      mccConjTrans(&JBt, &JB);
      
      
      /* lltrack=blfll(w, nd, vo); 		% Initial likelihood value */
      mccImport(&lltrack, (Matrix *) mlfBlfll(&w, &nd, &vo), 1, 56);
      /* lltol=abs(percoflll*lltrack); 		% Tolerance is 1% of likelihood */
      RM0_.dmode = mxNUMBER;
      {
         int m_=1, n_=1, cx_ = 0;
         double t_;
         double *p_RM0_;
         int I_RM0_=1;
         double *p_lltrack;
         int I_lltrack=1;
         m_ = mcmCalcResultSize(m_, &n_, lltrack.m, lltrack.n);
         mccAllocateMatrix(&RM0_, m_, n_);
         I_RM0_ = (RM0_.m != 1 || RM0_.n != 1);
         p_RM0_ = RM0_.pr;
         I_lltrack = (lltrack.m != 1 || lltrack.n != 1);
         p_lltrack = lltrack.pr;
         for (j_=0; j_<n_; ++j_)
         {
            for (i_=0; i_<m_; ++i_, p_RM0_+=I_RM0_, p_lltrack+=I_lltrack)
            {
               *p_RM0_ = (percoflll * *p_lltrack);
               ;
            }
         }
      }
      RM0_.dmode = mxNUMBER;
      mccAbs(&lltol, &RM0_);
      /* lldiff=lltol+1; 			% differnce > tolerance */
      {
         int m_=1, n_=1, cx_ = 0;
         double t_;
         double *p_lldiff;
         int I_lldiff=1;
         double *p_lltol;
         int I_lltol=1;
         m_ = mcmCalcResultSize(m_, &n_, lltol.m, lltol.n);
         mccAllocateMatrix(&lldiff, m_, n_);
         I_lldiff = (lldiff.m != 1 || lldiff.n != 1);
         p_lldiff = lldiff.pr;
         I_lltol = (lltol.m != 1 || lltol.n != 1);
         p_lltol = lltol.pr;
         for (j_=0; j_<n_; ++j_)
         {
            for (i_=0; i_<m_; ++i_, p_lldiff+=I_lldiff, p_lltol+=I_lltol)
            {
               *p_lldiff = (*p_lltol + 1);
               ;
            }
         }
      }
      lldiff.dmode = mxNUMBER;
      /* counter=0; */
      counter = 0;
      
      /* xi1 = v(1:mark1); */
      {
         int m_=1, n_=1, cx_ = 0;
         double t_;
         double *p_xi1;
         int I_xi1=1;
         double *p_v;
         int I_v=1;
         m_ = mccCalcSubscriptDimensions(m_, &n_, 1, ((int)(mark1 - 1) + 1), &v);
         mccAllocateMatrix(&xi1, m_, n_);
         I_xi1 = (xi1.m != 1 || xi1.n != 1);
         p_xi1 = xi1.pr;
         I_v = (v.m != 1 || v.n != 1);
         p_v = v.pr + ((int)(1 - .5));
         for (j_=0; j_<n_; ++j_)
         {
            for (i_=0; i_<m_; ++i_, p_xi1+=I_xi1, p_v+=I_v)
            {
               *p_xi1 = *p_v;
               ;
            }
         }
      }
      xi1.dmode = mxNUMBER;
      /* mark2 = mark1 + nrow1; */
      mark2 = (mark1 + nrow1);
      /* mu1 = v(mark1 + 1: mark2); */
      {
         int m_=1, n_=1, cx_ = 0;
         double t_;
         double *p_mu1;
         int I_mu1=1;
         double *p_v;
         int I_v=1;
         m_ = mccCalcSubscriptDimensions(m_, &n_, 1, ((int)(mark2 - (mark1 + 1)) + 1), &v);
         mccAllocateMatrix(&mu1, m_, n_);
         I_mu1 = (mu1.m != 1 || mu1.n != 1);
         p_mu1 = mu1.pr;
         I_v = (v.m != 1 || v.n != 1);
         p_v = v.pr + ((int)((mark1 + 1) - .5));
         for (j_=0; j_<n_; ++j_)
         {
            for (i_=0; i_<m_; ++i_, p_mu1+=I_mu1, p_v+=I_v)
            {
               *p_mu1 = *p_v;
               ;
            }
         }
      }
      mu1.dmode = mxNUMBER;
      /* mark3 = mark2 + nrow2; */
      mark3 = (mark2 + nrow2);
      /* xi2 = v(mark2 + 1: mark3); */
      {
         int m_=1, n_=1, cx_ = 0;
         double t_;
         double *p_xi2;
         int I_xi2=1;
         double *p_v;
         int I_v=1;
         m_ = mccCalcSubscriptDimensions(m_, &n_, 1, ((int)(mark3 - (mark2 + 1)) + 1), &v);
         mccAllocateMatrix(&xi2, m_, n_);
         I_xi2 = (xi2.m != 1 || xi2.n != 1);
         p_xi2 = xi2.pr;
         I_v = (v.m != 1 || v.n != 1);
         p_v = v.pr + ((int)((mark2 + 1) - .5));
         for (j_=0; j_<n_; ++j_)
         {
            for (i_=0; i_<m_; ++i_, p_xi2+=I_xi2, p_v+=I_v)
            {
               *p_xi2 = *p_v;
               ;
            }
         }
      }
      xi2.dmode = mxNUMBER;
      /* mark4 = mark3 + nrow2; */
      mark4 = (mark3 + nrow2);
      /* mu2 = v(mark3 + 1: mark4); */
      {
         int m_=1, n_=1, cx_ = 0;
         double t_;
         double *p_mu2;
         int I_mu2=1;
         double *p_v;
         int I_v=1;
         m_ = mccCalcSubscriptDimensions(m_, &n_, 1, ((int)(mark4 - (mark3 + 1)) + 1), &v);
         mccAllocateMatrix(&mu2, m_, n_);
         I_mu2 = (mu2.m != 1 || mu2.n != 1);
         p_mu2 = mu2.pr;
         I_v = (v.m != 1 || v.n != 1);
         p_v = v.pr + ((int)((mark3 + 1) - .5));
         for (j_=0; j_<n_; ++j_)
         {
            for (i_=0; i_<m_; ++i_, p_mu2+=I_mu2, p_v+=I_v)
            {
               *p_mu2 = *p_v;
               ;
            }
         }
      }
      mu2.dmode = mxNUMBER;
      /* mark5 = mark4 + nrow3; */
      mark5 = (mark4 + nrow3);
      /* xi3 = v(mark4 + 1: mark5); */
      {
         int m_=1, n_=1, cx_ = 0;
         double t_;
         double *p_xi3;
         int I_xi3=1;
         double *p_v;
         int I_v=1;
         m_ = mccCalcSubscriptDimensions(m_, &n_, 1, ((int)(mark5 - (mark4 + 1)) + 1), &v);
         mccAllocateMatrix(&xi3, m_, n_);
         I_xi3 = (xi3.m != 1 || xi3.n != 1);
         p_xi3 = xi3.pr;
         I_v = (v.m != 1 || v.n != 1);
         p_v = v.pr + ((int)((mark4 + 1) - .5));
         for (j_=0; j_<n_; ++j_)
         {
            for (i_=0; i_<m_; ++i_, p_xi3+=I_xi3, p_v+=I_v)
            {
               *p_xi3 = *p_v;
               ;
            }
         }
      }
      xi3.dmode = mxNUMBER;
      /* mark6 = mark5 + nrow3; */
      mark6 = (mark5 + nrow3);
      /* mu3 = v(mark5 + 1: mark6); */
      {
         int m_=1, n_=1, cx_ = 0;
         double t_;
         double *p_mu3;
         int I_mu3=1;
         double *p_v;
         int I_v=1;
         m_ = mccCalcSubscriptDimensions(m_, &n_, 1, ((int)(mark6 - (mark5 + 1)) + 1), &v);
         mccAllocateMatrix(&mu3, m_, n_);
         I_mu3 = (mu3.m != 1 || mu3.n != 1);
         p_mu3 = mu3.pr;
         I_v = (v.m != 1 || v.n != 1);
         p_v = v.pr + ((int)((mark5 + 1) - .5));
         for (j_=0; j_<n_; ++j_)
         {
            for (i_=0; i_<m_; ++i_, p_mu3+=I_mu3, p_v+=I_v)
            {
               *p_mu3 = *p_v;
               ;
            }
         }
      }
      mu3.dmode = mxNUMBER;
      /* % mu2m */
      /* % xi3m */
      
      
      /* if display */
      if (display)
      {
         /* fprintf('lltrack\tlltkold\tlltol\tlldiff\n')  */
         Mplhs_[0] = (Matrix *) mlfFprintf(&S1_, 0);
         mccPrint(Mplhs_[0], 0);
         mccFreeMatrix(Mplhs_[0]);
         /* end */
      }
      
      /* while lldiff>lltol & counter<maxiter */
      while (1)
      {
         I0_ = (counter < maxiter);
         RM0_.dmode = mxNUMBER;
         {
            int m_=1, n_=1, cx_ = 0;
            double t_;
            double *p_RM0_;
            int I_RM0_=1;
            double *p_lldiff;
            int I_lldiff=1;
            double *p_lltol;
            int I_lltol=1;
            m_ = mcmCalcResultSize(m_, &n_, lldiff.m, lldiff.n);
            m_ = mcmCalcResultSize(m_, &n_, lltol.m, lltol.n);
            mccAllocateMatrix(&RM0_, m_, n_);
            I_RM0_ = (RM0_.m != 1 || RM0_.n != 1);
            p_RM0_ = RM0_.pr;
            I_lldiff = (lldiff.m != 1 || lldiff.n != 1);
            p_lldiff = lldiff.pr;
            I_lltol = (lltol.m != 1 || lltol.n != 1);
            p_lltol = lltol.pr;
            for (j_=0; j_<n_; ++j_)
            {
               for (i_=0; i_<m_; ++i_, p_RM0_+=I_RM0_, p_lldiff+=I_lldiff, p_lltol+=I_lltol)
               {
                  *p_RM0_ = (!!(*p_lldiff > *p_lltol) && !!I0_);
                  ;
               }
            }
         }
         RM0_.dmode = mxNUMBER;
         if (!(mccIfCondition(&RM0_)))
            break;
         /* counter=counter+1; */
         counter = (counter + 1);
         
         
         
         /* vold=vo; */
         mccCopy(&vold, &vo);
         /* %Update xi3 for one iteration */
         /* for i=1:nrow3 */
         for (i = 1; i <= nrow3; i = i + 1)
         {
            /* vo(mark4+i) = minline(mu2, JB(i, :), h3(i), linemintol); */
            RM0_.dmode = mxNUMBER;
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_RM0_;
               int I_RM0_=1;
               double *p_JB;
               int I_JB=1, J_JB;
               m_ = mcmCalcResultSize(m_, &n_, 1, JB.n);
               mccAllocateMatrix(&RM0_, m_, n_);
               I_RM0_ = (RM0_.m != 1 || RM0_.n != 1);
               p_RM0_ = RM0_.pr;
               if (JB.m == 1 && JB.n == 1) { I_JB = J_JB = 0; }
               else { I_JB=1; J_JB=JB.m-m_; }
               p_JB = JB.pr + (i-1) + JB.m * 0;
               for (j_=0; j_<n_; ++j_, p_JB += J_JB)
               {
                  for (i_=0; i_<m_; ++i_, p_RM0_+=I_RM0_, p_JB+=I_JB)
                  {
                     *p_RM0_ = *p_JB;
                     ;
                  }
               }
            }
            RM0_.dmode = mxNUMBER;
            Mplhs_[0] = (Matrix *) mlfMinline(&mu2, &RM0_, mccTempVectorElement(&h3, i), mccTempMatrix(linemintol, 0., mxNUMBER));
            RC0_ = mccImportReal(&RC0__set_, Mplhs_[ 0 ], " (mfupdate, line 88): RC0_");
            vo.pr[(((int)(mark4 + i))-1)] = RC0_;
            vo.dmode = RC0__set_;
            /* end */
         }
         /* xi3=vo(mark4+1:mark5); */
         {
            int m_=1, n_=1, cx_ = 0;
            double t_;
            double *p_xi3;
            int I_xi3=1;
            double *p_vo;
            int I_vo=1;
            m_ = mccCalcSubscriptDimensions(m_, &n_, 1, ((int)(mark5 - (mark4 + 1)) + 1), &vo);
            mccAllocateMatrix(&xi3, m_, n_);
            I_xi3 = (xi3.m != 1 || xi3.n != 1);
            p_xi3 = xi3.pr;
            I_vo = (vo.m != 1 || vo.n != 1);
            p_vo = vo.pr + ((int)((mark4 + 1) - .5));
            for (j_=0; j_<n_; ++j_)
            {
               for (i_=0; i_<m_; ++i_, p_xi3+=I_xi3, p_vo+=I_vo)
               {
                  *p_xi3 = *p_vo;
                  ;
               }
            }
         }
         xi3.dmode = vo.dmode;
         /* tosser=xi3; */
         mccCopy(&tosser, &xi3);
         mccSetGlobal(&S2_, &tosser);
         /* %Update mu2 for one iteration */
         
         /* xi3m = ones(nrow2, 1)*xi3; */
         mccOnesMN(&RM0_, nrow2, 1);
         mccRealMatrixMultiply(&xi3m, &RM0_, &xi3);
         
         /* for index=1:nrow2 			%optimize row 2 */
         for (index = 1; index <= nrow2; index = index + 1)
         {
            
            /* mu2m = mu2'*ones(1, nrow3); */
            mccConjTrans(&RM0_, &mu2);
            mccOnesMN(&RM1_, 1, nrow3);
            mccRealMatrixMultiply(&mu2m, &RM0_, &RM1_);
            
            /* phi3 = exp(h3).* ... */
            mccImport(&RM1_, (Matrix *) mlfExp(&h3), 1, 100);
            RM0_.dmode = mxNUMBER;
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_RM0_;
               int I_RM0_=1;
               double *p_xi3m;
               int I_xi3m=1;
               double *p_JBt;
               int I_JBt=1;
               m_ = mcmCalcResultSize(m_, &n_, xi3m.m, xi3m.n);
               m_ = mcmCalcResultSize(m_, &n_, JBt.m, JBt.n);
               mccAllocateMatrix(&RM0_, m_, n_);
               I_RM0_ = (RM0_.m != 1 || RM0_.n != 1);
               p_RM0_ = RM0_.pr;
               I_xi3m = (xi3m.m != 1 || xi3m.n != 1);
               p_xi3m = xi3m.pr;
               I_JBt = (JBt.m != 1 || JBt.n != 1);
               p_JBt = JBt.pr;
               for (j_=0; j_<n_; ++j_)
               {
                  for (i_=0; i_<m_; ++i_, p_RM0_+=I_RM0_, p_xi3m+=I_xi3m, p_JBt+=I_JBt)
                  {
                     *p_RM0_ = ((1 - *p_xi3m) * *p_JBt);
                     ;
                  }
               }
            }
            RM0_.dmode = mxNUMBER;
            mccImport(&RM2_, (Matrix *) mlfExp(&RM0_), 1, 101);
            RM3_.dmode = mxNUMBER;
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_RM3_;
               int I_RM3_=1;
               double *p_mu2m;
               int I_mu2m=1;
               double *p_1mu2m;
               int I_1mu2m=1;
               double *p_RM2_;
               int I_RM2_=1;
               m_ = mcmCalcResultSize(m_, &n_, mu2m.m, mu2m.n);
               m_ = mcmCalcResultSize(m_, &n_, mu2m.m, mu2m.n);
               m_ = mcmCalcResultSize(m_, &n_, RM2_.m, RM2_.n);
               mccAllocateMatrix(&RM3_, m_, n_);
               I_RM3_ = (RM3_.m != 1 || RM3_.n != 1);
               p_RM3_ = RM3_.pr;
               I_mu2m = (mu2m.m != 1 || mu2m.n != 1);
               p_mu2m = mu2m.pr;
               I_1mu2m = (mu2m.m != 1 || mu2m.n != 1);
               p_1mu2m = mu2m.pr;
               I_RM2_ = (RM2_.m != 1 || RM2_.n != 1);
               p_RM2_ = RM2_.pr;
               for (j_=0; j_<n_; ++j_)
               {
                  for (i_=0; i_<m_; ++i_, p_RM3_+=I_RM3_, p_mu2m+=I_mu2m, p_1mu2m+=I_1mu2m, p_RM2_+=I_RM2_)
                  {
                     *p_RM3_ = ((1 - *p_mu2m) + (*p_1mu2m * *p_RM2_));
                     ;
                  }
               }
            }
            RM3_.dmode = mxNUMBER;
            mccImport(&RM4_, (Matrix *) mlfProd(&RM3_), 1, 101);
            RM5_.dmode = mxNUMBER;
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_RM5_;
               int I_RM5_=1;
               double *p_xi3m;
               int I_xi3m=1;
               double *p_JBt;
               int I_JBt=1;
               m_ = mcmCalcResultSize(m_, &n_, xi3m.m, xi3m.n);
               m_ = mcmCalcResultSize(m_, &n_, JBt.m, JBt.n);
               mccAllocateMatrix(&RM5_, m_, n_);
               I_RM5_ = (RM5_.m != 1 || RM5_.n != 1);
               p_RM5_ = RM5_.pr;
               I_xi3m = (xi3m.m != 1 || xi3m.n != 1);
               p_xi3m = xi3m.pr;
               I_JBt = (JBt.m != 1 || JBt.n != 1);
               p_JBt = JBt.pr;
               for (j_=0; j_<n_; ++j_)
               {
                  for (i_=0; i_<m_; ++i_, p_RM5_+=I_RM5_, p_xi3m+=I_xi3m, p_JBt+=I_JBt)
                  {
                     *p_RM5_ = ((-*p_xi3m) * *p_JBt);
                     ;
                  }
               }
            }
            RM5_.dmode = mxNUMBER;
            mccImport(&RM6_, (Matrix *) mlfExp(&RM5_), 1, 102);
            RM7_.dmode = mxNUMBER;
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_RM7_;
               int I_RM7_=1;
               double *p_mu2m;
               int I_mu2m=1;
               double *p_1mu2m;
               int I_1mu2m=1;
               double *p_RM6_;
               int I_RM6_=1;
               m_ = mcmCalcResultSize(m_, &n_, mu2m.m, mu2m.n);
               m_ = mcmCalcResultSize(m_, &n_, mu2m.m, mu2m.n);
               m_ = mcmCalcResultSize(m_, &n_, RM6_.m, RM6_.n);
               mccAllocateMatrix(&RM7_, m_, n_);
               I_RM7_ = (RM7_.m != 1 || RM7_.n != 1);
               p_RM7_ = RM7_.pr;
               I_mu2m = (mu2m.m != 1 || mu2m.n != 1);
               p_mu2m = mu2m.pr;
               I_1mu2m = (mu2m.m != 1 || mu2m.n != 1);
               p_1mu2m = mu2m.pr;
               I_RM6_ = (RM6_.m != 1 || RM6_.n != 1);
               p_RM6_ = RM6_.pr;
               for (j_=0; j_<n_; ++j_)
               {
                  for (i_=0; i_<m_; ++i_, p_RM7_+=I_RM7_, p_mu2m+=I_mu2m, p_1mu2m+=I_1mu2m, p_RM6_+=I_RM6_)
                  {
                     *p_RM7_ = ((1 - *p_mu2m) + (*p_1mu2m * *p_RM6_));
                     ;
                  }
               }
            }
            RM7_.dmode = mxNUMBER;
            mccImport(&RM8_, (Matrix *) mlfProd(&RM7_), 1, 102);
            mccImport(&RM9_, (Matrix *) mlfExp(&h3), 1, 103);
            RM10_.dmode = mxNUMBER;
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_RM10_;
               int I_RM10_=1;
               double *p_xi3m;
               int I_xi3m=1;
               double *p_JBt;
               int I_JBt=1;
               m_ = mcmCalcResultSize(m_, &n_, xi3m.m, xi3m.n);
               m_ = mcmCalcResultSize(m_, &n_, JBt.m, JBt.n);
               mccAllocateMatrix(&RM10_, m_, n_);
               I_RM10_ = (RM10_.m != 1 || RM10_.n != 1);
               p_RM10_ = RM10_.pr;
               I_xi3m = (xi3m.m != 1 || xi3m.n != 1);
               p_xi3m = xi3m.pr;
               I_JBt = (JBt.m != 1 || JBt.n != 1);
               p_JBt = JBt.pr;
               for (j_=0; j_<n_; ++j_)
               {
                  for (i_=0; i_<m_; ++i_, p_RM10_+=I_RM10_, p_xi3m+=I_xi3m, p_JBt+=I_JBt)
                  {
                     *p_RM10_ = ((1 - *p_xi3m) * *p_JBt);
                     ;
                  }
               }
            }
            RM10_.dmode = mxNUMBER;
            mccImport(&RM11_, (Matrix *) mlfExp(&RM10_), 1, 103);
            RM12_.dmode = mxNUMBER;
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_RM12_;
               int I_RM12_=1;
               double *p_mu2m;
               int I_mu2m=1;
               double *p_1mu2m;
               int I_1mu2m=1;
               double *p_RM11_;
               int I_RM11_=1;
               m_ = mcmCalcResultSize(m_, &n_, mu2m.m, mu2m.n);
               m_ = mcmCalcResultSize(m_, &n_, mu2m.m, mu2m.n);
               m_ = mcmCalcResultSize(m_, &n_, RM11_.m, RM11_.n);
               mccAllocateMatrix(&RM12_, m_, n_);
               I_RM12_ = (RM12_.m != 1 || RM12_.n != 1);
               p_RM12_ = RM12_.pr;
               I_mu2m = (mu2m.m != 1 || mu2m.n != 1);
               p_mu2m = mu2m.pr;
               I_1mu2m = (mu2m.m != 1 || mu2m.n != 1);
               p_1mu2m = mu2m.pr;
               I_RM11_ = (RM11_.m != 1 || RM11_.n != 1);
               p_RM11_ = RM11_.pr;
               for (j_=0; j_<n_; ++j_)
               {
                  for (i_=0; i_<m_; ++i_, p_RM12_+=I_RM12_, p_mu2m+=I_mu2m, p_1mu2m+=I_1mu2m, p_RM11_+=I_RM11_)
                  {
                     *p_RM12_ = ((1 - *p_mu2m) + (*p_1mu2m * *p_RM11_));
                     ;
                  }
               }
            }
            RM12_.dmode = mxNUMBER;
            mccImport(&RM13_, (Matrix *) mlfProd(&RM12_), 1, 103);
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_phi3;
               int I_phi3=1;
               double *p_RM1_;
               int I_RM1_=1;
               double *p_RM4_;
               int I_RM4_=1;
               double *p_RM8_;
               int I_RM8_=1;
               double *p_RM9_;
               int I_RM9_=1;
               double *p_RM13_;
               int I_RM13_=1;
               m_ = mcmCalcResultSize(m_, &n_, RM1_.m, RM1_.n);
               m_ = mcmCalcResultSize(m_, &n_, RM4_.m, RM4_.n);
               m_ = mcmCalcResultSize(m_, &n_, RM8_.m, RM8_.n);
               m_ = mcmCalcResultSize(m_, &n_, RM9_.m, RM9_.n);
               m_ = mcmCalcResultSize(m_, &n_, RM13_.m, RM13_.n);
               mccAllocateMatrix(&phi3, m_, n_);
               I_phi3 = (phi3.m != 1 || phi3.n != 1);
               p_phi3 = phi3.pr;
               I_RM1_ = (RM1_.m != 1 || RM1_.n != 1);
               p_RM1_ = RM1_.pr;
               I_RM4_ = (RM4_.m != 1 || RM4_.n != 1);
               p_RM4_ = RM4_.pr;
               I_RM8_ = (RM8_.m != 1 || RM8_.n != 1);
               p_RM8_ = RM8_.pr;
               I_RM9_ = (RM9_.m != 1 || RM9_.n != 1);
               p_RM9_ = RM9_.pr;
               I_RM13_ = (RM13_.m != 1 || RM13_.n != 1);
               p_RM13_ = RM13_.pr;
               for (j_=0; j_<n_; ++j_)
               {
                  for (i_=0; i_<m_; ++i_, p_phi3+=I_phi3, p_RM1_+=I_RM1_, p_RM4_+=I_RM4_, p_RM8_+=I_RM8_, p_RM9_+=I_RM9_, p_RM13_+=I_RM13_)
                  {
                     *p_phi3 = ((*p_RM1_ * *p_RM4_) / (double) (*p_RM8_ + (*p_RM9_ * *p_RM13_)));
                     ;
                  }
               }
            }
            phi3.dmode = mxNUMBER;
            
            /* phi3m = ones(size(mu2'))*phi3; */
            mccConjTrans(&RM13_, &mu2);
            mccSize(&RM12_, &RM13_);
            mccOnes(&RM11_, &RM12_);
            mccRealMatrixMultiply(&phi3m, &RM11_, &phi3);
            
            /* K_ji = (1-phi3m).*(1-exp(-xi3m.*JBt))./... */
            RM11_.dmode = mxNUMBER;
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_RM11_;
               int I_RM11_=1;
               double *p_xi3m;
               int I_xi3m=1;
               double *p_JBt;
               int I_JBt=1;
               m_ = mcmCalcResultSize(m_, &n_, xi3m.m, xi3m.n);
               m_ = mcmCalcResultSize(m_, &n_, JBt.m, JBt.n);
               mccAllocateMatrix(&RM11_, m_, n_);
               I_RM11_ = (RM11_.m != 1 || RM11_.n != 1);
               p_RM11_ = RM11_.pr;
               I_xi3m = (xi3m.m != 1 || xi3m.n != 1);
               p_xi3m = xi3m.pr;
               I_JBt = (JBt.m != 1 || JBt.n != 1);
               p_JBt = JBt.pr;
               for (j_=0; j_<n_; ++j_)
               {
                  for (i_=0; i_<m_; ++i_, p_RM11_+=I_RM11_, p_xi3m+=I_xi3m, p_JBt+=I_JBt)
                  {
                     *p_RM11_ = ((-*p_xi3m) * *p_JBt);
                     ;
                  }
               }
            }
            RM11_.dmode = mxNUMBER;
            mccImport(&RM12_, (Matrix *) mlfExp(&RM11_), 1, 107);
            RM13_.dmode = mxNUMBER;
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_RM13_;
               int I_RM13_=1;
               double *p_xi3m;
               int I_xi3m=1;
               double *p_JBt;
               int I_JBt=1;
               m_ = mcmCalcResultSize(m_, &n_, xi3m.m, xi3m.n);
               m_ = mcmCalcResultSize(m_, &n_, JBt.m, JBt.n);
               mccAllocateMatrix(&RM13_, m_, n_);
               I_RM13_ = (RM13_.m != 1 || RM13_.n != 1);
               p_RM13_ = RM13_.pr;
               I_xi3m = (xi3m.m != 1 || xi3m.n != 1);
               p_xi3m = xi3m.pr;
               I_JBt = (JBt.m != 1 || JBt.n != 1);
               p_JBt = JBt.pr;
               for (j_=0; j_<n_; ++j_)
               {
                  for (i_=0; i_<m_; ++i_, p_RM13_+=I_RM13_, p_xi3m+=I_xi3m, p_JBt+=I_JBt)
                  {
                     *p_RM13_ = ((-*p_xi3m) * *p_JBt);
                     ;
                  }
               }
            }
            RM13_.dmode = mxNUMBER;
            mccImport(&RM10_, (Matrix *) mlfExp(&RM13_), 1, 108);
            RM9_.dmode = mxNUMBER;
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_RM9_;
               int I_RM9_=1;
               double *p_xi3m;
               int I_xi3m=1;
               double *p_JBt;
               int I_JBt=1;
               m_ = mcmCalcResultSize(m_, &n_, xi3m.m, xi3m.n);
               m_ = mcmCalcResultSize(m_, &n_, JBt.m, JBt.n);
               mccAllocateMatrix(&RM9_, m_, n_);
               I_RM9_ = (RM9_.m != 1 || RM9_.n != 1);
               p_RM9_ = RM9_.pr;
               I_xi3m = (xi3m.m != 1 || xi3m.n != 1);
               p_xi3m = xi3m.pr;
               I_JBt = (JBt.m != 1 || JBt.n != 1);
               p_JBt = JBt.pr;
               for (j_=0; j_<n_; ++j_)
               {
                  for (i_=0; i_<m_; ++i_, p_RM9_+=I_RM9_, p_xi3m+=I_xi3m, p_JBt+=I_JBt)
                  {
                     *p_RM9_ = ((1 - *p_xi3m) * *p_JBt);
                     ;
                  }
               }
            }
            RM9_.dmode = mxNUMBER;
            mccImport(&RM8_, (Matrix *) mlfExp(&RM9_), 1, 109);
            RM7_.dmode = mxNUMBER;
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_RM7_;
               int I_RM7_=1;
               double *p_xi3m;
               int I_xi3m=1;
               double *p_JBt;
               int I_JBt=1;
               m_ = mcmCalcResultSize(m_, &n_, xi3m.m, xi3m.n);
               m_ = mcmCalcResultSize(m_, &n_, JBt.m, JBt.n);
               mccAllocateMatrix(&RM7_, m_, n_);
               I_RM7_ = (RM7_.m != 1 || RM7_.n != 1);
               p_RM7_ = RM7_.pr;
               I_xi3m = (xi3m.m != 1 || xi3m.n != 1);
               p_xi3m = xi3m.pr;
               I_JBt = (JBt.m != 1 || JBt.n != 1);
               p_JBt = JBt.pr;
               for (j_=0; j_<n_; ++j_)
               {
                  for (i_=0; i_<m_; ++i_, p_RM7_+=I_RM7_, p_xi3m+=I_xi3m, p_JBt+=I_JBt)
                  {
                     *p_RM7_ = ((1 - *p_xi3m) * *p_JBt);
                     ;
                  }
               }
            }
            RM7_.dmode = mxNUMBER;
            mccImport(&RM6_, (Matrix *) mlfExp(&RM7_), 1, 110);
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_K_ji;
               int I_K_ji=1;
               double *p_phi3m;
               int I_phi3m=1;
               double *p_RM12_;
               int I_RM12_=1;
               double *p_mu2m;
               int I_mu2m=1;
               double *p_1mu2m;
               int I_1mu2m=1;
               double *p_RM10_;
               int I_RM10_=1;
               double *p_1phi3m;
               int I_1phi3m=1;
               double *p_RM8_;
               int I_RM8_=1;
               double *p_2mu2m;
               int I_2mu2m=1;
               double *p_3mu2m;
               int I_3mu2m=1;
               double *p_RM6_;
               int I_RM6_=1;
               m_ = mcmCalcResultSize(m_, &n_, phi3m.m, phi3m.n);
               m_ = mcmCalcResultSize(m_, &n_, RM12_.m, RM12_.n);
               m_ = mcmCalcResultSize(m_, &n_, mu2m.m, mu2m.n);
               m_ = mcmCalcResultSize(m_, &n_, mu2m.m, mu2m.n);
               m_ = mcmCalcResultSize(m_, &n_, RM10_.m, RM10_.n);
               m_ = mcmCalcResultSize(m_, &n_, phi3m.m, phi3m.n);
               m_ = mcmCalcResultSize(m_, &n_, RM8_.m, RM8_.n);
               m_ = mcmCalcResultSize(m_, &n_, mu2m.m, mu2m.n);
               m_ = mcmCalcResultSize(m_, &n_, mu2m.m, mu2m.n);
               m_ = mcmCalcResultSize(m_, &n_, RM6_.m, RM6_.n);
               mccAllocateMatrix(&K_ji, m_, n_);
               I_K_ji = (K_ji.m != 1 || K_ji.n != 1);
               p_K_ji = K_ji.pr;
               I_phi3m = (phi3m.m != 1 || phi3m.n != 1);
               p_phi3m = phi3m.pr;
               I_RM12_ = (RM12_.m != 1 || RM12_.n != 1);
               p_RM12_ = RM12_.pr;
               I_mu2m = (mu2m.m != 1 || mu2m.n != 1);
               p_mu2m = mu2m.pr;
               I_1mu2m = (mu2m.m != 1 || mu2m.n != 1);
               p_1mu2m = mu2m.pr;
               I_RM10_ = (RM10_.m != 1 || RM10_.n != 1);
               p_RM10_ = RM10_.pr;
               I_1phi3m = (phi3m.m != 1 || phi3m.n != 1);
               p_1phi3m = phi3m.pr;
               I_RM8_ = (RM8_.m != 1 || RM8_.n != 1);
               p_RM8_ = RM8_.pr;
               I_2mu2m = (mu2m.m != 1 || mu2m.n != 1);
               p_2mu2m = mu2m.pr;
               I_3mu2m = (mu2m.m != 1 || mu2m.n != 1);
               p_3mu2m = mu2m.pr;
               I_RM6_ = (RM6_.m != 1 || RM6_.n != 1);
               p_RM6_ = RM6_.pr;
               for (j_=0; j_<n_; ++j_)
               {
                  for (i_=0; i_<m_; ++i_, p_K_ji+=I_K_ji, p_phi3m+=I_phi3m, p_RM12_+=I_RM12_, p_mu2m+=I_mu2m, p_1mu2m+=I_1mu2m, p_RM10_+=I_RM10_, p_1phi3m+=I_1phi3m, p_RM8_+=I_RM8_, p_2mu2m+=I_2mu2m, p_3mu2m+=I_3mu2m, p_RM6_+=I_RM6_)
                  {
                     *p_K_ji = ((((1 - *p_phi3m) * (1 - *p_RM12_)) / (double) ((1 - *p_mu2m) + (*p_1mu2m * *p_RM10_))) + ((*p_1phi3m * (1 - *p_RM8_)) / (double) ((1 - *p_2mu2m) + (*p_3mu2m * *p_RM6_))));
                     ;
                  }
               }
            }
            K_ji.dmode = mxNUMBER;
            
            /* vo(mark3 + index) = 1./(1+exp(-(h2(index)+ ... */
            RM6_.dmode = mxNUMBER;
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_RM6_;
               int I_RM6_=1;
               double *p_JA;
               int I_JA=1, J_JA;
               m_ = mcmCalcResultSize(m_, &n_, 1, JA.n);
               mccAllocateMatrix(&RM6_, m_, n_);
               I_RM6_ = (RM6_.m != 1 || RM6_.n != 1);
               p_RM6_ = RM6_.pr;
               if (JA.m == 1 && JA.n == 1) { I_JA = J_JA = 0; }
               else { I_JA=1; J_JA=JA.m-m_; }
               p_JA = JA.pr + (index-1) + JA.m * 0;
               for (j_=0; j_<n_; ++j_, p_JA += J_JA)
               {
                  for (i_=0; i_<m_; ++i_, p_RM6_+=I_RM6_, p_JA+=I_JA)
                  {
                     *p_RM6_ = *p_JA;
                     ;
                  }
               }
            }
            RM6_.dmode = mxNUMBER;
            mccConjTrans(&RM7_, &mu1);
            R0_ = mccRealInnerProduct(&RM6_, &RM7_);
            RM8_.dmode = mxNUMBER;
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_RM8_;
               int I_RM8_=1;
               double *p_mu3;
               int I_mu3=1;
               double *p_xi3;
               int I_xi3=1;
               m_ = mcmCalcResultSize(m_, &n_, mu3.m, mu3.n);
               m_ = mcmCalcResultSize(m_, &n_, xi3.m, xi3.n);
               mccAllocateMatrix(&RM8_, m_, n_);
               I_RM8_ = (RM8_.m != 1 || RM8_.n != 1);
               p_RM8_ = RM8_.pr;
               I_mu3 = (mu3.m != 1 || mu3.n != 1);
               p_mu3 = mu3.pr;
               I_xi3 = (xi3.m != 1 || xi3.n != 1);
               p_xi3 = xi3.pr;
               for (j_=0; j_<n_; ++j_)
               {
                  for (i_=0; i_<m_; ++i_, p_RM8_+=I_RM8_, p_mu3+=I_mu3, p_xi3+=I_xi3)
                  {
                     *p_RM8_ = (*p_mu3 - *p_xi3);
                     ;
                  }
               }
            }
            RM8_.dmode = mxNUMBER;
            RM9_.dmode = mxNUMBER;
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_RM9_;
               int I_RM9_=1;
               double *p_JB;
               int I_JB=1, J_JB;
               m_ = mcmCalcResultSize(m_, &n_, JB.m, 1);
               mccAllocateMatrix(&RM9_, m_, n_);
               I_RM9_ = (RM9_.m != 1 || RM9_.n != 1);
               p_RM9_ = RM9_.pr;
               if (JB.m == 1 && JB.n == 1) { I_JB = J_JB = 0; }
               else { I_JB=1; J_JB=JB.m-m_; }
               p_JB = JB.pr + 0 + JB.m * (index-1);
               for (j_=0; j_<n_; ++j_, p_JB += J_JB)
               {
                  for (i_=0; i_<m_; ++i_, p_RM9_+=I_RM9_, p_JB+=I_JB)
                  {
                     *p_RM9_ = *p_JB;
                     ;
                  }
               }
            }
            RM9_.dmode = mxNUMBER;
            R1_ = mccRealInnerProduct(&RM8_, &RM9_);
            RM10_.dmode = mxNUMBER;
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_RM10_;
               int I_RM10_=1;
               double *p_K_ji;
               int I_K_ji=1, J_K_ji;
               m_ = mcmCalcResultSize(m_, &n_, 1, K_ji.n);
               mccAllocateMatrix(&RM10_, m_, n_);
               I_RM10_ = (RM10_.m != 1 || RM10_.n != 1);
               p_RM10_ = RM10_.pr;
               if (K_ji.m == 1 && K_ji.n == 1) { I_K_ji = J_K_ji = 0; }
               else { I_K_ji=1; J_K_ji=K_ji.m-m_; }
               p_K_ji = K_ji.pr + (index-1) + K_ji.m * 0;
               for (j_=0; j_<n_; ++j_, p_K_ji += J_K_ji)
               {
                  for (i_=0; i_<m_; ++i_, p_RM10_+=I_RM10_, p_K_ji+=I_K_ji)
                  {
                     *p_RM10_ = *p_K_ji;
                     ;
                  }
               }
            }
            RM10_.dmode = mxNUMBER;
            mccConjTrans(&RM13_, &RM10_);
            vo.pr[(((int)(mark3 + index))-1)] = (1 / (double) (1 + exp((-((((h2.pr[(index-1)]) + R0_) + R1_) + mccRealVectorSum(&RM13_))))));
            vo.dmode = mxNUMBER;
            
            /* mu2(index)=vo(mark3 + index); */
            mu2.pr[(index-1)] = (vo.pr[(((int)(mark3 + index))-1)]);
            mu2.dmode = mxNUMBER;
            
            /* end */
         }
         
         /* %Update xi2 for one iteration */
         /* for i=1:nrow2 */
         for (i = 1; i <= nrow2; i = i + 1)
         {
            /* vo(mark2+i) = minline(mu1, JA(i, :), h2(i), linemintol);  */
            RM13_.dmode = mxNUMBER;
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_RM13_;
               int I_RM13_=1;
               double *p_JA;
               int I_JA=1, J_JA;
               m_ = mcmCalcResultSize(m_, &n_, 1, JA.n);
               mccAllocateMatrix(&RM13_, m_, n_);
               I_RM13_ = (RM13_.m != 1 || RM13_.n != 1);
               p_RM13_ = RM13_.pr;
               if (JA.m == 1 && JA.n == 1) { I_JA = J_JA = 0; }
               else { I_JA=1; J_JA=JA.m-m_; }
               p_JA = JA.pr + (i-1) + JA.m * 0;
               for (j_=0; j_<n_; ++j_, p_JA += J_JA)
               {
                  for (i_=0; i_<m_; ++i_, p_RM13_+=I_RM13_, p_JA+=I_JA)
                  {
                     *p_RM13_ = *p_JA;
                     ;
                  }
               }
            }
            RM13_.dmode = mxNUMBER;
            Mplhs_[0] = (Matrix *) mlfMinline(&mu1, &RM13_, mccTempVectorElement(&h2, i), mccTempMatrix(linemintol, 0., mxNUMBER));
            RC0_ = mccImportReal(&RC0__set_, Mplhs_[ 0 ], " (mfupdate, line 123): RC0_");
            vo.pr[(((int)(mark2 + i))-1)] = RC0_;
            vo.dmode = mxNUMBER;
            /* end */
         }
         /* xi2=vo(mark2+1:mark3); */
         {
            int m_=1, n_=1, cx_ = 0;
            double t_;
            double *p_xi2;
            int I_xi2=1;
            double *p_vo;
            int I_vo=1;
            m_ = mccCalcSubscriptDimensions(m_, &n_, 1, ((int)(mark3 - (mark2 + 1)) + 1), &vo);
            mccAllocateMatrix(&xi2, m_, n_);
            I_xi2 = (xi2.m != 1 || xi2.n != 1);
            p_xi2 = xi2.pr;
            I_vo = (vo.m != 1 || vo.n != 1);
            p_vo = vo.pr + ((int)((mark2 + 1) - .5));
            for (j_=0; j_<n_; ++j_)
            {
               for (i_=0; i_<m_; ++i_, p_xi2+=I_xi2, p_vo+=I_vo)
               {
                  *p_xi2 = *p_vo;
                  ;
               }
            }
         }
         xi2.dmode = mxNUMBER;
         
         /* xi2m = ones(nrow1, 1)*xi2; */
         mccOnesMN(&RM13_, nrow1, 1);
         mccRealMatrixMultiply(&xi2m, &RM13_, &xi2);
         
         /* for index=1:nrow1  %optimize row 1  */
         for (index = 1; index <= nrow1; index = index + 1)
         {
            
            /* mu1m = mu1'*ones(1, nrow2); */
            mccConjTrans(&RM13_, &mu1);
            mccOnesMN(&RM10_, 1, nrow2);
            mccRealMatrixMultiply(&mu1m, &RM13_, &RM10_);
            
            /* phi2 = exp(h2).* ... */
            mccImport(&RM10_, (Matrix *) mlfExp(&h2), 1, 133);
            RM13_.dmode = mxNUMBER;
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_RM13_;
               int I_RM13_=1;
               double *p_xi2m;
               int I_xi2m=1;
               double *p_JAt;
               int I_JAt=1;
               m_ = mcmCalcResultSize(m_, &n_, xi2m.m, xi2m.n);
               m_ = mcmCalcResultSize(m_, &n_, JAt.m, JAt.n);
               mccAllocateMatrix(&RM13_, m_, n_);
               I_RM13_ = (RM13_.m != 1 || RM13_.n != 1);
               p_RM13_ = RM13_.pr;
               I_xi2m = (xi2m.m != 1 || xi2m.n != 1);
               p_xi2m = xi2m.pr;
               I_JAt = (JAt.m != 1 || JAt.n != 1);
               p_JAt = JAt.pr;
               for (j_=0; j_<n_; ++j_)
               {
                  for (i_=0; i_<m_; ++i_, p_RM13_+=I_RM13_, p_xi2m+=I_xi2m, p_JAt+=I_JAt)
                  {
                     *p_RM13_ = ((1 - *p_xi2m) * *p_JAt);
                     ;
                  }
               }
            }
            RM13_.dmode = mxNUMBER;
            mccImport(&RM9_, (Matrix *) mlfExp(&RM13_), 1, 134);
            RM8_.dmode = mxNUMBER;
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_RM8_;
               int I_RM8_=1;
               double *p_mu1m;
               int I_mu1m=1;
               double *p_1mu1m;
               int I_1mu1m=1;
               double *p_RM9_;
               int I_RM9_=1;
               m_ = mcmCalcResultSize(m_, &n_, mu1m.m, mu1m.n);
               m_ = mcmCalcResultSize(m_, &n_, mu1m.m, mu1m.n);
               m_ = mcmCalcResultSize(m_, &n_, RM9_.m, RM9_.n);
               mccAllocateMatrix(&RM8_, m_, n_);
               I_RM8_ = (RM8_.m != 1 || RM8_.n != 1);
               p_RM8_ = RM8_.pr;
               I_mu1m = (mu1m.m != 1 || mu1m.n != 1);
               p_mu1m = mu1m.pr;
               I_1mu1m = (mu1m.m != 1 || mu1m.n != 1);
               p_1mu1m = mu1m.pr;
               I_RM9_ = (RM9_.m != 1 || RM9_.n != 1);
               p_RM9_ = RM9_.pr;
               for (j_=0; j_<n_; ++j_)
               {
                  for (i_=0; i_<m_; ++i_, p_RM8_+=I_RM8_, p_mu1m+=I_mu1m, p_1mu1m+=I_1mu1m, p_RM9_+=I_RM9_)
                  {
                     *p_RM8_ = ((1 - *p_mu1m) + (*p_1mu1m * *p_RM9_));
                     ;
                  }
               }
            }
            RM8_.dmode = mxNUMBER;
            mccImport(&RM7_, (Matrix *) mlfProd(&RM8_), 1, 134);
            RM6_.dmode = mxNUMBER;
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_RM6_;
               int I_RM6_=1;
               double *p_xi2m;
               int I_xi2m=1;
               double *p_JAt;
               int I_JAt=1;
               m_ = mcmCalcResultSize(m_, &n_, xi2m.m, xi2m.n);
               m_ = mcmCalcResultSize(m_, &n_, JAt.m, JAt.n);
               mccAllocateMatrix(&RM6_, m_, n_);
               I_RM6_ = (RM6_.m != 1 || RM6_.n != 1);
               p_RM6_ = RM6_.pr;
               I_xi2m = (xi2m.m != 1 || xi2m.n != 1);
               p_xi2m = xi2m.pr;
               I_JAt = (JAt.m != 1 || JAt.n != 1);
               p_JAt = JAt.pr;
               for (j_=0; j_<n_; ++j_)
               {
                  for (i_=0; i_<m_; ++i_, p_RM6_+=I_RM6_, p_xi2m+=I_xi2m, p_JAt+=I_JAt)
                  {
                     *p_RM6_ = ((-*p_xi2m) * *p_JAt);
                     ;
                  }
               }
            }
            RM6_.dmode = mxNUMBER;
            mccImport(&RM12_, (Matrix *) mlfExp(&RM6_), 1, 135);
            RM11_.dmode = mxNUMBER;
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_RM11_;
               int I_RM11_=1;
               double *p_mu1m;
               int I_mu1m=1;
               double *p_1mu1m;
               int I_1mu1m=1;
               double *p_RM12_;
               int I_RM12_=1;
               m_ = mcmCalcResultSize(m_, &n_, mu1m.m, mu1m.n);
               m_ = mcmCalcResultSize(m_, &n_, mu1m.m, mu1m.n);
               m_ = mcmCalcResultSize(m_, &n_, RM12_.m, RM12_.n);
               mccAllocateMatrix(&RM11_, m_, n_);
               I_RM11_ = (RM11_.m != 1 || RM11_.n != 1);
               p_RM11_ = RM11_.pr;
               I_mu1m = (mu1m.m != 1 || mu1m.n != 1);
               p_mu1m = mu1m.pr;
               I_1mu1m = (mu1m.m != 1 || mu1m.n != 1);
               p_1mu1m = mu1m.pr;
               I_RM12_ = (RM12_.m != 1 || RM12_.n != 1);
               p_RM12_ = RM12_.pr;
               for (j_=0; j_<n_; ++j_)
               {
                  for (i_=0; i_<m_; ++i_, p_RM11_+=I_RM11_, p_mu1m+=I_mu1m, p_1mu1m+=I_1mu1m, p_RM12_+=I_RM12_)
                  {
                     *p_RM11_ = ((1 - *p_mu1m) + (*p_1mu1m * *p_RM12_));
                     ;
                  }
               }
            }
            RM11_.dmode = mxNUMBER;
            mccImport(&RM5_, (Matrix *) mlfProd(&RM11_), 1, 135);
            mccImport(&RM4_, (Matrix *) mlfExp(&h2), 1, 136);
            RM3_.dmode = mxNUMBER;
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_RM3_;
               int I_RM3_=1;
               double *p_xi2m;
               int I_xi2m=1;
               double *p_JAt;
               int I_JAt=1;
               m_ = mcmCalcResultSize(m_, &n_, xi2m.m, xi2m.n);
               m_ = mcmCalcResultSize(m_, &n_, JAt.m, JAt.n);
               mccAllocateMatrix(&RM3_, m_, n_);
               I_RM3_ = (RM3_.m != 1 || RM3_.n != 1);
               p_RM3_ = RM3_.pr;
               I_xi2m = (xi2m.m != 1 || xi2m.n != 1);
               p_xi2m = xi2m.pr;
               I_JAt = (JAt.m != 1 || JAt.n != 1);
               p_JAt = JAt.pr;
               for (j_=0; j_<n_; ++j_)
               {
                  for (i_=0; i_<m_; ++i_, p_RM3_+=I_RM3_, p_xi2m+=I_xi2m, p_JAt+=I_JAt)
                  {
                     *p_RM3_ = ((1 - *p_xi2m) * *p_JAt);
                     ;
                  }
               }
            }
            RM3_.dmode = mxNUMBER;
            mccImport(&RM2_, (Matrix *) mlfExp(&RM3_), 1, 136);
            RM0_.dmode = mxNUMBER;
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_RM0_;
               int I_RM0_=1;
               double *p_mu1m;
               int I_mu1m=1;
               double *p_1mu1m;
               int I_1mu1m=1;
               double *p_RM2_;
               int I_RM2_=1;
               m_ = mcmCalcResultSize(m_, &n_, mu1m.m, mu1m.n);
               m_ = mcmCalcResultSize(m_, &n_, mu1m.m, mu1m.n);
               m_ = mcmCalcResultSize(m_, &n_, RM2_.m, RM2_.n);
               mccAllocateMatrix(&RM0_, m_, n_);
               I_RM0_ = (RM0_.m != 1 || RM0_.n != 1);
               p_RM0_ = RM0_.pr;
               I_mu1m = (mu1m.m != 1 || mu1m.n != 1);
               p_mu1m = mu1m.pr;
               I_1mu1m = (mu1m.m != 1 || mu1m.n != 1);
               p_1mu1m = mu1m.pr;
               I_RM2_ = (RM2_.m != 1 || RM2_.n != 1);
               p_RM2_ = RM2_.pr;
               for (j_=0; j_<n_; ++j_)
               {
                  for (i_=0; i_<m_; ++i_, p_RM0_+=I_RM0_, p_mu1m+=I_mu1m, p_1mu1m+=I_1mu1m, p_RM2_+=I_RM2_)
                  {
                     *p_RM0_ = ((1 - *p_mu1m) + (*p_1mu1m * *p_RM2_));
                     ;
                  }
               }
            }
            RM0_.dmode = mxNUMBER;
            mccImport(&RM1_, (Matrix *) mlfProd(&RM0_), 1, 136);
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_phi2;
               int I_phi2=1;
               double *p_RM10_;
               int I_RM10_=1;
               double *p_RM7_;
               int I_RM7_=1;
               double *p_RM5_;
               int I_RM5_=1;
               double *p_RM4_;
               int I_RM4_=1;
               double *p_RM1_;
               int I_RM1_=1;
               m_ = mcmCalcResultSize(m_, &n_, RM10_.m, RM10_.n);
               m_ = mcmCalcResultSize(m_, &n_, RM7_.m, RM7_.n);
               m_ = mcmCalcResultSize(m_, &n_, RM5_.m, RM5_.n);
               m_ = mcmCalcResultSize(m_, &n_, RM4_.m, RM4_.n);
               m_ = mcmCalcResultSize(m_, &n_, RM1_.m, RM1_.n);
               mccAllocateMatrix(&phi2, m_, n_);
               I_phi2 = (phi2.m != 1 || phi2.n != 1);
               p_phi2 = phi2.pr;
               I_RM10_ = (RM10_.m != 1 || RM10_.n != 1);
               p_RM10_ = RM10_.pr;
               I_RM7_ = (RM7_.m != 1 || RM7_.n != 1);
               p_RM7_ = RM7_.pr;
               I_RM5_ = (RM5_.m != 1 || RM5_.n != 1);
               p_RM5_ = RM5_.pr;
               I_RM4_ = (RM4_.m != 1 || RM4_.n != 1);
               p_RM4_ = RM4_.pr;
               I_RM1_ = (RM1_.m != 1 || RM1_.n != 1);
               p_RM1_ = RM1_.pr;
               for (j_=0; j_<n_; ++j_)
               {
                  for (i_=0; i_<m_; ++i_, p_phi2+=I_phi2, p_RM10_+=I_RM10_, p_RM7_+=I_RM7_, p_RM5_+=I_RM5_, p_RM4_+=I_RM4_, p_RM1_+=I_RM1_)
                  {
                     *p_phi2 = ((*p_RM10_ * *p_RM7_) / (double) (*p_RM5_ + (*p_RM4_ * *p_RM1_)));
                     ;
                  }
               }
            }
            phi2.dmode = mxNUMBER;
            
            /* phi2m = ones(size(mu1'))*phi2; */
            mccConjTrans(&RM1_, &mu1);
            mccSize(&RM0_, &RM1_);
            mccOnes(&RM2_, &RM0_);
            mccRealMatrixMultiply(&phi2m, &RM2_, &phi2);
            
            /* K_ji = (1-phi2m).*(1-exp(-xi2m.*JAt))./... */
            RM2_.dmode = mxNUMBER;
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_RM2_;
               int I_RM2_=1;
               double *p_xi2m;
               int I_xi2m=1;
               double *p_JAt;
               int I_JAt=1;
               m_ = mcmCalcResultSize(m_, &n_, xi2m.m, xi2m.n);
               m_ = mcmCalcResultSize(m_, &n_, JAt.m, JAt.n);
               mccAllocateMatrix(&RM2_, m_, n_);
               I_RM2_ = (RM2_.m != 1 || RM2_.n != 1);
               p_RM2_ = RM2_.pr;
               I_xi2m = (xi2m.m != 1 || xi2m.n != 1);
               p_xi2m = xi2m.pr;
               I_JAt = (JAt.m != 1 || JAt.n != 1);
               p_JAt = JAt.pr;
               for (j_=0; j_<n_; ++j_)
               {
                  for (i_=0; i_<m_; ++i_, p_RM2_+=I_RM2_, p_xi2m+=I_xi2m, p_JAt+=I_JAt)
                  {
                     *p_RM2_ = ((-*p_xi2m) * *p_JAt);
                     ;
                  }
               }
            }
            RM2_.dmode = mxNUMBER;
            mccImport(&RM0_, (Matrix *) mlfExp(&RM2_), 1, 140);
            RM1_.dmode = mxNUMBER;
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_RM1_;
               int I_RM1_=1;
               double *p_xi2m;
               int I_xi2m=1;
               double *p_JAt;
               int I_JAt=1;
               m_ = mcmCalcResultSize(m_, &n_, xi2m.m, xi2m.n);
               m_ = mcmCalcResultSize(m_, &n_, JAt.m, JAt.n);
               mccAllocateMatrix(&RM1_, m_, n_);
               I_RM1_ = (RM1_.m != 1 || RM1_.n != 1);
               p_RM1_ = RM1_.pr;
               I_xi2m = (xi2m.m != 1 || xi2m.n != 1);
               p_xi2m = xi2m.pr;
               I_JAt = (JAt.m != 1 || JAt.n != 1);
               p_JAt = JAt.pr;
               for (j_=0; j_<n_; ++j_)
               {
                  for (i_=0; i_<m_; ++i_, p_RM1_+=I_RM1_, p_xi2m+=I_xi2m, p_JAt+=I_JAt)
                  {
                     *p_RM1_ = ((-*p_xi2m) * *p_JAt);
                     ;
                  }
               }
            }
            RM1_.dmode = mxNUMBER;
            mccImport(&RM3_, (Matrix *) mlfExp(&RM1_), 1, 141);
            RM4_.dmode = mxNUMBER;
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_RM4_;
               int I_RM4_=1;
               double *p_xi2m;
               int I_xi2m=1;
               double *p_JAt;
               int I_JAt=1;
               m_ = mcmCalcResultSize(m_, &n_, xi2m.m, xi2m.n);
               m_ = mcmCalcResultSize(m_, &n_, JAt.m, JAt.n);
               mccAllocateMatrix(&RM4_, m_, n_);
               I_RM4_ = (RM4_.m != 1 || RM4_.n != 1);
               p_RM4_ = RM4_.pr;
               I_xi2m = (xi2m.m != 1 || xi2m.n != 1);
               p_xi2m = xi2m.pr;
               I_JAt = (JAt.m != 1 || JAt.n != 1);
               p_JAt = JAt.pr;
               for (j_=0; j_<n_; ++j_)
               {
                  for (i_=0; i_<m_; ++i_, p_RM4_+=I_RM4_, p_xi2m+=I_xi2m, p_JAt+=I_JAt)
                  {
                     *p_RM4_ = ((1 - *p_xi2m) * *p_JAt);
                     ;
                  }
               }
            }
            RM4_.dmode = mxNUMBER;
            mccImport(&RM5_, (Matrix *) mlfExp(&RM4_), 1, 142);
            RM11_.dmode = mxNUMBER;
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_RM11_;
               int I_RM11_=1;
               double *p_xi2m;
               int I_xi2m=1;
               double *p_JAt;
               int I_JAt=1;
               m_ = mcmCalcResultSize(m_, &n_, xi2m.m, xi2m.n);
               m_ = mcmCalcResultSize(m_, &n_, JAt.m, JAt.n);
               mccAllocateMatrix(&RM11_, m_, n_);
               I_RM11_ = (RM11_.m != 1 || RM11_.n != 1);
               p_RM11_ = RM11_.pr;
               I_xi2m = (xi2m.m != 1 || xi2m.n != 1);
               p_xi2m = xi2m.pr;
               I_JAt = (JAt.m != 1 || JAt.n != 1);
               p_JAt = JAt.pr;
               for (j_=0; j_<n_; ++j_)
               {
                  for (i_=0; i_<m_; ++i_, p_RM11_+=I_RM11_, p_xi2m+=I_xi2m, p_JAt+=I_JAt)
                  {
                     *p_RM11_ = ((1 - *p_xi2m) * *p_JAt);
                     ;
                  }
               }
            }
            RM11_.dmode = mxNUMBER;
            mccImport(&RM12_, (Matrix *) mlfExp(&RM11_), 1, 143);
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_K_ji;
               int I_K_ji=1;
               double *p_phi2m;
               int I_phi2m=1;
               double *p_RM0_;
               int I_RM0_=1;
               double *p_mu1m;
               int I_mu1m=1;
               double *p_1mu1m;
               int I_1mu1m=1;
               double *p_RM3_;
               int I_RM3_=1;
               double *p_1phi2m;
               int I_1phi2m=1;
               double *p_RM5_;
               int I_RM5_=1;
               double *p_2mu1m;
               int I_2mu1m=1;
               double *p_3mu1m;
               int I_3mu1m=1;
               double *p_RM12_;
               int I_RM12_=1;
               m_ = mcmCalcResultSize(m_, &n_, phi2m.m, phi2m.n);
               m_ = mcmCalcResultSize(m_, &n_, RM0_.m, RM0_.n);
               m_ = mcmCalcResultSize(m_, &n_, mu1m.m, mu1m.n);
               m_ = mcmCalcResultSize(m_, &n_, mu1m.m, mu1m.n);
               m_ = mcmCalcResultSize(m_, &n_, RM3_.m, RM3_.n);
               m_ = mcmCalcResultSize(m_, &n_, phi2m.m, phi2m.n);
               m_ = mcmCalcResultSize(m_, &n_, RM5_.m, RM5_.n);
               m_ = mcmCalcResultSize(m_, &n_, mu1m.m, mu1m.n);
               m_ = mcmCalcResultSize(m_, &n_, mu1m.m, mu1m.n);
               m_ = mcmCalcResultSize(m_, &n_, RM12_.m, RM12_.n);
               mccAllocateMatrix(&K_ji, m_, n_);
               I_K_ji = (K_ji.m != 1 || K_ji.n != 1);
               p_K_ji = K_ji.pr;
               I_phi2m = (phi2m.m != 1 || phi2m.n != 1);
               p_phi2m = phi2m.pr;
               I_RM0_ = (RM0_.m != 1 || RM0_.n != 1);
               p_RM0_ = RM0_.pr;
               I_mu1m = (mu1m.m != 1 || mu1m.n != 1);
               p_mu1m = mu1m.pr;
               I_1mu1m = (mu1m.m != 1 || mu1m.n != 1);
               p_1mu1m = mu1m.pr;
               I_RM3_ = (RM3_.m != 1 || RM3_.n != 1);
               p_RM3_ = RM3_.pr;
               I_1phi2m = (phi2m.m != 1 || phi2m.n != 1);
               p_1phi2m = phi2m.pr;
               I_RM5_ = (RM5_.m != 1 || RM5_.n != 1);
               p_RM5_ = RM5_.pr;
               I_2mu1m = (mu1m.m != 1 || mu1m.n != 1);
               p_2mu1m = mu1m.pr;
               I_3mu1m = (mu1m.m != 1 || mu1m.n != 1);
               p_3mu1m = mu1m.pr;
               I_RM12_ = (RM12_.m != 1 || RM12_.n != 1);
               p_RM12_ = RM12_.pr;
               for (j_=0; j_<n_; ++j_)
               {
                  for (i_=0; i_<m_; ++i_, p_K_ji+=I_K_ji, p_phi2m+=I_phi2m, p_RM0_+=I_RM0_, p_mu1m+=I_mu1m, p_1mu1m+=I_1mu1m, p_RM3_+=I_RM3_, p_1phi2m+=I_1phi2m, p_RM5_+=I_RM5_, p_2mu1m+=I_2mu1m, p_3mu1m+=I_3mu1m, p_RM12_+=I_RM12_)
                  {
                     *p_K_ji = ((((1 - *p_phi2m) * (1 - *p_RM0_)) / (double) ((1 - *p_mu1m) + (*p_1mu1m * *p_RM3_))) + ((*p_1phi2m * (1 - *p_RM5_)) / (double) ((1 - *p_2mu1m) + (*p_3mu1m * *p_RM12_))));
                     ;
                  }
               }
            }
            K_ji.dmode = mxNUMBER;
            
            /* vo(mark1+index) = 1./(1+exp(-(h1(index)+... */
            RM12_.dmode = mxNUMBER;
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_RM12_;
               int I_RM12_=1;
               double *p_mu2;
               int I_mu2=1;
               double *p_xi2;
               int I_xi2=1;
               m_ = mcmCalcResultSize(m_, &n_, mu2.m, mu2.n);
               m_ = mcmCalcResultSize(m_, &n_, xi2.m, xi2.n);
               mccAllocateMatrix(&RM12_, m_, n_);
               I_RM12_ = (RM12_.m != 1 || RM12_.n != 1);
               p_RM12_ = RM12_.pr;
               I_mu2 = (mu2.m != 1 || mu2.n != 1);
               p_mu2 = mu2.pr;
               I_xi2 = (xi2.m != 1 || xi2.n != 1);
               p_xi2 = xi2.pr;
               for (j_=0; j_<n_; ++j_)
               {
                  for (i_=0; i_<m_; ++i_, p_RM12_+=I_RM12_, p_mu2+=I_mu2, p_xi2+=I_xi2)
                  {
                     *p_RM12_ = (*p_mu2 - *p_xi2);
                     ;
                  }
               }
            }
            RM12_.dmode = mxNUMBER;
            RM11_.dmode = mxNUMBER;
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_RM11_;
               int I_RM11_=1;
               double *p_JA;
               int I_JA=1, J_JA;
               m_ = mcmCalcResultSize(m_, &n_, JA.m, 1);
               mccAllocateMatrix(&RM11_, m_, n_);
               I_RM11_ = (RM11_.m != 1 || RM11_.n != 1);
               p_RM11_ = RM11_.pr;
               if (JA.m == 1 && JA.n == 1) { I_JA = J_JA = 0; }
               else { I_JA=1; J_JA=JA.m-m_; }
               p_JA = JA.pr + 0 + JA.m * (index-1);
               for (j_=0; j_<n_; ++j_, p_JA += J_JA)
               {
                  for (i_=0; i_<m_; ++i_, p_RM11_+=I_RM11_, p_JA+=I_JA)
                  {
                     *p_RM11_ = *p_JA;
                     ;
                  }
               }
            }
            RM11_.dmode = mxNUMBER;
            R1_ = mccRealInnerProduct(&RM12_, &RM11_);
            RM5_.dmode = mxNUMBER;
            {
               int m_=1, n_=1, cx_ = 0;
               double t_;
               double *p_RM5_;
               int I_RM5_=1;
               double *p_K_ji;
               int I_K_ji=1, J_K_ji;
               m_ = mcmCalcResultSize(m_, &n_, 1, K_ji.n);
               mccAllocateMatrix(&RM5_, m_, n_);
               I_RM5_ = (RM5_.m != 1 || RM5_.n != 1);
               p_RM5_ = RM5_.pr;
               if (K_ji.m == 1 && K_ji.n == 1) { I_K_ji = J_K_ji = 0; }
               else { I_K_ji=1; J_K_ji=K_ji.m-m_; }
               p_K_ji = K_ji.pr + (index-1) + K_ji.m * 0;
               for (j_=0; j_<n_; ++j_, p_K_ji += J_K_ji)
               {
                  for (i_=0; i_<m_; ++i_, p_RM5_+=I_RM5_, p_K_ji+=I_K_ji)
                  {
                     *p_RM5_ = *p_K_ji;
                     ;
                  }
               }
            }
            RM5_.dmode = mxNUMBER;
            mccConjTrans(&RM4_, &RM5_);
            vo.pr[(((int)(mark1 + index))-1)] = (1 / (double) (1 + exp((-(((h1.pr[(index-1)]) + R1_) + mccRealVectorSum(&RM4_))))));
            vo.dmode = mxNUMBER;
            
            /* mu1(index)=vo(mark1+index); */
            mu1.pr[(index-1)] = (vo.pr[(((int)(mark1 + index))-1)]);
            mu1.dmode = mxNUMBER;
            
            /* end */
         }
         
         /* lltrackold=lltrack; */
         mccCopy(&lltrackold, &lltrack);
         /* lltrack=blfll(w, nd, vo); */
         mccImport(&lltrack, (Matrix *) mlfBlfll(&w, &nd, &vo), 1, 154);
         /* lldiff=lltrack-lltrackold; */
         {
            int m_=1, n_=1, cx_ = 0;
            double t_;
            double *p_lldiff;
            int I_lldiff=1;
            double *p_lltrack;
            int I_lltrack=1;
            double *p_lltrackold;
            int I_lltrackold=1;
            m_ = mcmCalcResultSize(m_, &n_, lltrack.m, lltrack.n);
            m_ = mcmCalcResultSize(m_, &n_, lltrackold.m, lltrackold.n);
            mccAllocateMatrix(&lldiff, m_, n_);
            I_lldiff = (lldiff.m != 1 || lldiff.n != 1);
            p_lldiff = lldiff.pr;
            I_lltrack = (lltrack.m != 1 || lltrack.n != 1);
            p_lltrack = lltrack.pr;
            I_lltrackold = (lltrackold.m != 1 || lltrackold.n != 1);
            p_lltrackold = lltrackold.pr;
            for (j_=0; j_<n_; ++j_)
            {
               for (i_=0; i_<m_; ++i_, p_lldiff+=I_lldiff, p_lltrack+=I_lltrack, p_lltrackold+=I_lltrackold)
               {
                  *p_lldiff = (*p_lltrack - *p_lltrackold);
                  ;
               }
            }
         }
         lldiff.dmode = mxNUMBER;
         /* lltol=abs(percoflll*lltrackold); */
         RM4_.dmode = mxNUMBER;
         {
            int m_=1, n_=1, cx_ = 0;
            double t_;
            double *p_RM4_;
            int I_RM4_=1;
            double *p_lltrackold;
            int I_lltrackold=1;
            m_ = mcmCalcResultSize(m_, &n_, lltrackold.m, lltrackold.n);
            mccAllocateMatrix(&RM4_, m_, n_);
            I_RM4_ = (RM4_.m != 1 || RM4_.n != 1);
            p_RM4_ = RM4_.pr;
            I_lltrackold = (lltrackold.m != 1 || lltrackold.n != 1);
            p_lltrackold = lltrackold.pr;
            for (j_=0; j_<n_; ++j_)
            {
               for (i_=0; i_<m_; ++i_, p_RM4_+=I_RM4_, p_lltrackold+=I_lltrackold)
               {
                  *p_RM4_ = (percoflll * *p_lltrackold);
                  ;
               }
            }
         }
         RM4_.dmode = mxNUMBER;
         mccAbs(&lltol, &RM4_);
         
         /* if display */
         if (display)
         {
            /* fprintf('%3.2f\t%3.2f\t%2.3f\t%2.3f\n', ... */
            Mplhs_[0] = (Matrix *) mlfFprintf(&S3_, &lltrack, &lltrackold, &lltol, &lldiff, 0);
            mccPrint(Mplhs_[0], 0);
            mccFreeMatrix(Mplhs_[0]);
            /* end 					%  */
         }
         
         
         /* end */
      }
      
      /* if counter==maxiter */
      if ((counter == maxiter))
      {
         
         /* fprintf(['Maximum iterations reached in mmfupdate\n' ... */
         Mplhs_[0] = (Matrix *) mlfFprintf(&S0_, &lldiff, &lltol, 0);
         mccPrint(Mplhs_[0], 0);
         mccFreeMatrix(Mplhs_[0]);
         /* end  */
      }
      mccReturnFirstValue(&vo_lhs_, &vo);
      if (nlhs_ > 1) mccReturnScalar(counter_lhs_, counter, 0., mccSET|mccNOTFIRST);
      mccFreeMatrix(&vo);
      mccFreeMatrix(&w);
      mccFreeMatrix(&nd);
      mccFreeMatrix(&v);
      mccFreeMatrix(&options);
      mccFreeMatrix(&h1);
      mccFreeMatrix(&JA);
      mccFreeMatrix(&h2);
      mccFreeMatrix(&JB);
      mccFreeMatrix(&h3);
      mccFreeMatrix(&JAt);
      mccFreeMatrix(&JBt);
      mccFreeMatrix(&lltrack);
      mccFreeMatrix(&lltol);
      mccFreeMatrix(&lldiff);
      mccFreeMatrix(&xi1);
      mccFreeMatrix(&mu1);
      mccFreeMatrix(&xi2);
      mccFreeMatrix(&mu2);
      mccFreeMatrix(&xi3);
      mccFreeMatrix(&mu3);
      mccFreeMatrix(&vold);
      mccFreeMatrix(&tosser);
      mccFreeMatrix(&xi3m);
      mccFreeMatrix(&mu2m);
      mccFreeMatrix(&phi3);
      mccFreeMatrix(&phi3m);
      mccFreeMatrix(&K_ji);
      mccFreeMatrix(&xi2m);
      mccFreeMatrix(&mu1m);
      mccFreeMatrix(&phi2);
      mccFreeMatrix(&phi2m);
      mccFreeMatrix(&lltrackold);
      mccFreeMatrix(&RM0_);
      mccFreeMatrix(&RM1_);
      mccFreeMatrix(&RM2_);
      mccFreeMatrix(&RM3_);
      mccFreeMatrix(&RM4_);
      mccFreeMatrix(&RM5_);
      mccFreeMatrix(&RM6_);
      mccFreeMatrix(&RM7_);
      mccFreeMatrix(&RM8_);
      mccFreeMatrix(&RM9_);
      mccFreeMatrix(&RM10_);
      mccFreeMatrix(&RM11_);
      mccFreeMatrix(&RM12_);
      mccFreeMatrix(&RM13_);
      return(vo_lhs_);
   }
}
