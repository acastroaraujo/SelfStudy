P. Aronow & B. Miller (2019) ***Foundations of Agnostic Statistics***, Cambridge University Press

****

- ___Agnostic statistics___ considers what can be learned about the world without assuming that there exists a simple generative model that can be known to be true.

- Credible research is incompatible with incredible modeling assumptions.

****

# **Probability Review**

****

**Frequentist probability**. The probability of an event describes the proportion of times that event can be expected to occur among many realizations of a random generative process. It's all about long-term frequencies.

The mathematical construct of randomness is a _modeling assumption_, not necessarily a fundamental feature of reality. It allows us to model the outcomes of a process, stripping away all the complexities that would otherwise allow us to predict any outcome _with certainty_.

****

There are three formal components that together fully describe a random generative process: $\Omega, S, P$.

The **sample space** ($\Omega$) or the set of all possible outcomes of a random generative process. Individual outcomes (or sets of outcomes) are usually denoted as $w \in \Omega$, and they can take many forms.

For example:
    
- A single roll of a six-sided die.

$$\Omega = \{1, 2, 3, 4, 5, 6\}$$

- A single roll of two six-sided dice.

$$
\Omega = \underbrace{\{(x, y) \in \mathbb Z^2 : 1 \leq x \leq 6,\ 1 \leq y \leq 6 \}}_\text{set builder notation}
$$

- A coin flip.

$$\Omega = \{H, T\}$$

An *event* is a well-defined subset of $\Omega$, usually denoted by capital Roman letters (e.g. $A \subseteq \Omega$).

For example:

- Rolling an even number with a six-sided die.

$$A = \{2, 4, 6\}$$


A set of subsets of $\Omega$ is an **event space** ($S$) if it satisfies the following properties:

- non-empty 

$$S \neq \varnothing$$

- closed under complements

$$A \in S \to A^C \in S$$

- closed under countable unions

$$A_1, A_2, ... \in S \to A_1 \cup A_2 \cup ... \in S$$

_Each event in an event space will have an associated probability of occurring_, and these properties ensure that certain types of events will always have well-defined probabilities.

A **probability measure** ($P$) is a function $f: S \to [0, 1]$ that assigns a probability to every event in the event space.

To ensure that this function $P$ assigns probabilities to events in a manner that is coherent and in accord with basic intuitions about probabilities, we follow the *Kolmogorov probability axioms*.

***

**Kolmogorov probability axioms**

$(\Omega, S, P)$ form a *probability space* when the following conditions hold:

1. Non-negativity, for any $A \in S$

$$0 \leq P(A) \leq 1$$

2. Unitary (or normalization)

$$P(\Omega) = 1$$

3. Countable additivity, if $A_1, A_2, ... \in S$ are *pairwise disjoint*, then

$$P(A_1 \cup A_2, \cup ...) = P(A_1) + P(A_2) + ... $$

We can represent any random generative process as a probability space $(\Omega,S,P)$.

***

Several other fundamental properties of probability follow directly from the Kolmogorov axioms:

Let $A, B \in S$

- **Monotonicity**

$$A \subseteq B \to P(A) \leq P(B)$$

- **Subtraction rule**

$$A \subseteq B \to P(B \setminus A) = P(B) - P(A)$$ 

- *Some* event in $S$ *must* occur

$$P(\varnothing) = 0$$

- **Complement rule**

$$P(A^C) = 1 - P(A)$$

### Joint and conditional probabilities

The **joint probability** of of $A$ and $B$ (i.e. that both events will ocur in a single draw from $(\Omega, S, P)$) is denoted as $P(A \cap B)$.

For example, the probability of rolling a six-sided die and getting $A = \{\omega \in \Omega: \omega \geq 4\}$ *and* $B = \{\omega \in \Omega: \omega \text{ is even}\}$ is as follows:

$$
P(A \cap B) = P(\{4, 5, 6\} \cap \{2, 4, 6\}) = \frac{|\{4, 6\}|}{|\Omega|} = \frac{1}{3}
$$

- **Addition rule**

$$P(A \cup B) = P(A) + P(B) - P(A \cap B)$$

The **conditional probability** of $A$ given $B$ is denoted as

$$P(A \mid B) = \frac{P(A \cap B)}{P(B)}$$

- **Product rule**

$$P(A \mid B) P(B) = P(A \cap B)$$

- **Bayes' rule**

$$P(A \mid B) = \frac{P(B \mid A) P(A)}{P(B)}$$


The **law of total probability** states that if $\{A_1, A_2, A_3, ...\}$ is a **partition** of $\Omega$ and $B \in S$, then

$$
P(B) = \sum_i P(B \cap A_i) = \sum_i \underbrace{P(B \mid A_i) P(A_i)}_\text{product rule}
$$

In other words, the probability of an event $B$ is effectively a weighted average of the conditional probabilities of that event ($B$).

****

**Events and conditional probabilities**. When writing $\Pr(A\mid E)$, we do *not* mean that $A \mid E$ is an event and that we're taking its probability. 

$$A \mid E \hspace{0.3cm} \text{is not an event!}$$

- $\Pr(A \mid E)$ is a probability function which assigns probabilities in accordance with the knowledge that $E$ has occurred.

- $\Pr(A)$ is a different probability function which assigns probabilities without regard for whether $E$ has occurred or not. 

### Independence

Events $A, B \in S$ are ***independent*** if $P(A \cap B) = P(A)P(B)$. This also implies the following:

$$A \perp B \iff P(A \mid B) = P(A)$$

That is, when $A$ and $B$ are independent, knowing whether or not $B$ has occurred gives us no information about the probability that $A$ has occurred. This is a very strong assumption, but it lies in the heart of many applications in statistics that work with independent and identically distributed (*i.i.d.*) random variables.

- **Conditional independence**

$$A \perp B \mid E \iff P(A \cap B \mid E) = P(A \mid E) P(B \mid E)$$

This is different from saying that $A$ and $B$ are independent themselves.

In general:

- Two events can be conditionally independent given $E$, but not independent. 

- Two events can be independent, but not conditionally independent given $E$. 

- Two events can be conditionally independent given $E$, but not independent given $E^C$. 

## Random Variables

A **random variable**, $X$, is a function from the sample space, $\Omega$, to some subset of $\mathbb{R}$ with a probability-based rule.

$$X: \Omega \to \mathbb R$$

Recall that each $\omega \in \Omega$ denotes a state of the world. A random variable $X$ will take take on the value $X(\omega)$. 

For example, the event $\{X = 1\}$ should be understood the set of of states of the world such that $X(\omega) = 1$.

$$
P(\{X = 1\}) = P(\{\omega \in \Omega: X(\omega) = 1\})
$$

There are two ways in which to apply functions to random variables:

1. **Function of a random variable**. Use the value of $X(\omega)$ as input into another function $g$, with the result being another random variable.

    $$g \circ X: \Omega \to \mathbb R$$
    
    For example:
    
    $$
    g(X) = \begin{cases} 1 &\text{if } X>0 \\ 0  &\text{otherwise}
    \end{cases}
    $$
    
2. **Operator on random variable**. These will summarize the properties of random variables such as *expectations* or *variances*. We use the $[\cdot]$ notation to denote operators.

We use uppercase to denote random variables and lowercase to denote particular realizations (or variables in the regular, algebraic sense).

- A **discrete random variable** can only can take on a finite (or countably infinite) number of different values.

- A **continuous random variable** can take on a continuum of possible values. Loosely speaking, a random variable is continuous if its CDF is continuous.

### PMFs, PDFs, and CDFs

Given a discrete random variable $X$, we can summarize the probability of each outcome $x$ occurring with a **probability mass function** (PMF). A continuous random variable is characterized by its **probability density function** (PDF).

$$
\underbrace{f(x) = P(X = x)}_\text{PMF} \hspace{1cm} 
\int_a^b \underbrace{f(x)}_\text{PDF}dx = P(a \leq X \leq b)
$$

Note that both functions must be non-negative 

$$f(x) \geq 0 \hspace{0.5cm} \text{ for all } x \in \mathbb R$$

These functions tell us *most* of what we need to know about the **distribution** of random variables (i.e. the complete collection of probabilities assigned to events defined in terms of $X$).

The **cumulative distribution function** (CDF) tell us *everything* we need to know about the distribution of random variables. More importantly, a CDF is defined the same way for both discrete *and* continuous random.

The CDF of $X$ is defined as

$$F(x) = P(X \leq x) \hspace{0.5cm} \text{ for all } x \in \mathbb R$$

In other words, the CDF returns the probability that an outcome for a random variable will be less than or equal to a given value.

Any CDF $F$ will have the following properties:

- **$F$ is nondecreasing as $x$ increases**

$$x_1 < x_2 \to F(x_1) < F(x_2)$$

- Limits

$$
\lim_{x \to +\infty} F(x) = 1 \hspace{0.5cm}
\lim_{x \to -\infty} F(x) = 0
$$

- **Complement rule**

$$1-F(x) = P(X > x)$$

- **Continuity from the right**. A CDF is always continuous from the right, even if the random variable is discrete (in which case the CDF is a "step function").

$$\lim_{x \to a^+} F(x) = F(a)$$

In the case of *continuous random variables*, note that the PDF is contained inside the definition of the CDF.

$$
\overbrace{F(a) = P(X \leq a) = \int_{-\infty}^a \underbrace{f(x)}_\text{PDF}dx}^\text{Cumulative Distribution Function}
$$

That is a probability **density** is the rate of change in cumulative probability. So where cumulative probability is increasing rapidly, density can easily exceed 1. But if we calculate the area under the density function, it will never exceed 1. In other words, the PDF is a "slope" that is defined according to the Fundamental Theorem of Calculus as follows:

$$\underbrace{f(x) = \frac{dF(u)}{du} \bigg|_{u = x}}_\text{Probability Density Function}$$

****

**Two additional definitions.**

- **Support**. . The set of values at which the PMF (or PDF) is positive is called its support.

$$
\textsf{supp}(X) = \{x \in \mathbb R: f(x) > 0\}
$$

- The inverse of a CDF ($Q = F^{-1}$) is called the **quantile function**. 

    For example:

$$
\underbrace{Q(0.5)}_\text{median} = x \iff P(X \leq x) = 0.5
$$

## Relationships

When we say two random variables are equal, we mean that they are *equal as functions*; they assign the same value to every state of the world.

$$
X = Y \iff X(\omega) = Y(\omega)\hspace{0.5cm} \forall \omega \in \Omega
$$

**Discrete multivariate distributions** are described by their *joint* CDF, PMF, or PDF.

$$
\overbrace{F(a, b) = P(X \leq a \cap Y \leq b) = \int_{-\infty}^a \int_{-\infty}^b \underbrace{f(x, y)}_\text{joint PDF}dy dx}^\text{joint CDF}
$$

The same as before, integrating over a PDF will give us probability statements such as

$$
P(a \leq X \leq b, c \leq Y \leq d) = \int_a^b \int_c^d f(x, y)dydx
$$

The same goes for summing over a PMF:

$$
P(a \leq X \leq b, c \leq Y \leq d) = \sum_{x = a}^b \sum_{y = c}^d f(x, y)
$$

And the "slope" interpretation extends to multiple variables too:

$$
\underbrace{f(x, y) = \frac{\partial F(u, v)}{\partial u \partial v} \bigg|_{u = x, v = y}}_\text{Joint Probability Density Function}
$$

And for the discrete setting:

$$
\underbrace{f(x, y) = P(X = x, Y = y)}_\text{Joint Probability Mass Function}
$$

**Marginalization**. We can go from multivariate to univariate distributions with summation (for PMFs) or integration (for PDFs). Both of these follow from the *law of total probability*.

- **Marginal PMF**

$$
f_Y(y) = P(Y = y) = \sum_{\textsf{Supp}[X]} f_{X, Y}(x, y)
$$

- **Marginal PDF**

$$
\text{Continuous: }f_Y(y) = \int_{-\infty}^\infty f_{X, Y}(x, y)dx
$$

**Conditional Distributions**. The *conditional PMF* of $Y$ given $X$ tells us the probability that a given value of $Y$ will occur, given that a certain value of $X$ occurs. In contrast, the conditional PDF of $Y$ given $X$ is just the PDF of $Y$ given that a certain value of $X$ occurs.

- **Conditional PMF**

$$
\begin{align}
f_{Y \mid X}(y \mid x) = P(Y = y \mid X = x) = \frac{f(x, y)}{f(x)} \\\\ \forall y \in \mathbb R \text{ and } \underbrace{\forall x \in \textsf{supp}(X)}_{\text{denominator} \neq 0}
\end{align}
$$

- **Conditional PDF**

$$
f_{Y \mid X}(y \mid x)  = \frac{f(x, y)}{f(x)} \hspace{0.5cm} \forall y \in \mathbb R \text{ and } \forall x \in \textsf{Supp}[X]
$$

- **Product rule for PMFs and PDFs**

$$
f(x \mid y)f(y) = f(x, y)
$$

- **Independence of random variables** regardless of whether they are discrete or continuous.

$$X \perp Y \iff f(x, y) = f(x) f(y)$$

$$X \perp Y \iff f(x \mid y) = f(x)$$

### Multivariate notation

A **random vector** of length $K$ is a vector whose components are random variables:

$$
\mathbf X (\omega) = \pmatrix{X_{[1]} (\omega), & \dots, & X_{[K]} (\omega)}
$$

Here, we use bracketed subscripts to denote distinct random variables because later on we use plain subscripts to denote multiple independent realizations of a single random variable.

The use of boldface will make us be able to express complicated expressions in a simple manner.

For example:

$$
\underbrace{F(\mathbf x)}_\text{CDF} = P(\mathbf X \leq \mathbf x) = P(X_{[1]} \leq x_{[1]}, X_{[2]} \leq x_{[2]}, \dots, X_{[K]} \leq x_{[K]}) 
$$

And if we have a continuous random vector, we have the following expression:

$$
F(\mathbf x) = \int_{-\infty}^{x_{[1]}} \int_{-\infty}^{x_{[2]}} \dots \int_{-\infty}^{x_{[K]}} = f(u_{[1]}, u_{[2]}, \dots, u_{[K]})du_{[K]} \dots du_{[2]}du_{[1]}
$$

****

## Summarizing distributions

****

### Expectation

The expected value (also known as the *expectation* or *mean*) is the most common measure of the "center" of a probability distribution. 

- Discrete random variables

$$
E[X] = \sum_{\textsf{supp}(x)} x f(x)
$$

- Continuous random variables

$$
E[X] = \int_{-\infty}^\infty x f(x)dx
$$

- **Properties of expected values**

$$
\begin{align}
&E[c] = c &\text{ for all } c \in \mathbb R \\\\
&E[cX] = c\ E[X]  &\text{ for all } c \in \mathbb R
\end{align}
$$

- Expectation of a Bernoulli random variable

$$
E[X] = P(X = 1) = p
$$

****

**Expectation of a function of a random variable** (also known as _LOTUS_). This result is far from obvious, and it comes up in many applications (e.g. finding the *variance* of a random variable).

- Continuous case

$$E[g(X)] = \int_{-\infty}^\infty g(x) f_X(x) dx$$

- Discrete case

$$E[g(X)] = \sum_{\textsf{supp}(x)} g(x) f_X(x)$$

The authors don't provide a proof for this result, so instead I'll show here how it plays out. This requires some rudimentary knowledge of **transformations**, which also omited from the book (see Blitzstein & Hwang 2019).

For simplicity, let's assume that $Y = g(X)$.

$$
\underbrace{f_Y(y) = f_X(x) \left| \frac{d x}{dy} \right|}_\text{Transformation}
$$

We can then express $E[Y]$ as follows:

$$
\begin{align}
E[Y] &= \int_{-\infty}^\infty y\ f_X(x)\left| \frac{d x}{dy} \right| dy \\\\ &= \int_{-\infty}^\infty g(x)\ f_X(x)dx
\end{align}
$$

**Example: The expectation of a standard log-normal distribution**

Suppose we have the following random variables:

- $Y = g(X) = e^X$ and $\frac{dy}{dx} = e^x$

- $X \sim \textsf{normal}(0, 1)$

**Without LOTUS**

Because $f_Y(y)$ is unknown, we need to first figure it out through the use of *transformations*.

$$f_Y(y) = \varphi(x) \left| \frac{d x}{dy} \right| = \varphi(\log y)\frac{1}{y}$$

And then the expectation is obtained as follows:

$$
\begin{align}
E[Y] &= \int_0^\infty \varphi(\log y) dy \\\\ &=
\int_0^\infty \frac{1}{\sqrt{2 \pi}} \exp\left(- \frac{1}{2} \log^2 y\right) dy \\\\ &= \sqrt{e}
\end{align}
$$

**With LOTUS**

$$
\begin{align}
E[g(X)] &= \int_{-\infty}^\infty g(x) \varphi(x) dx \\\\ &= \int_{-\infty}^\infty  \frac{1}{\sqrt{2 \pi}} \exp\left(x - \frac{x^2}{2}\right) \\\\ &= \sqrt{e}
\end{align}
$$

LOTUS is quicker because we can ignore *transformations* and the way in which they change the integral bounds!

****

- **Linearity of expectations**

$$E[aX + bY + c] = aE[X] + bE[Y] + c$$

Note that this property follows from considering the expectation of a function of a bivariate joint distribution.

$$\underbrace{g(X, Y) = aX + bY + c}_\text{function of a bivariate joint distribution}$$

Apply *LOTUS* and *marginalization*:

$$
\begin{align}
E[g(X, Y)] &= \sum_x \sum_y g(X, Y) f_{XY}(x,y) \\\\ &= 
\sum_x \sum_y (ax + by + c) f_{XY}(x,y) \\\\ &=
a\sum_x \sum_y x f_{XY}(x,y) +  b\sum_x \sum_y y f_{XY}(x,y)+ c\sum_x \sum_y f_{XY}(x,y)
\end{align}
$$

### Moments and variances

We can generalize expectations to further characterize the features of a distribution. This is the idea of **raw moments**, among which the expected value is just a special case.

$$
\underbrace{\mu_j^\prime = E[X^j]}_{j^{th}\text{ raw moment }}
$$

Raw moments provide summary information about a distribution, describing elements of its *shape* and *location*. 

- **Central moments**

$$\mu_j = E\left[(X - E[X])^j\right]$$

The sole distinction between raw and central moments lies in whether or not the expected value of $X$ is subtracted before calculations.


- The **variance** (second central moment)

$$
V[X] = E\left[(X - E[X])^2\right] = E\left[X^2\right] - E[X]^2
$$

The variance measures the expected value of the squared difference between the observed value of $X$ and its mean. Note that the first central moment equals zero.

- **Properties of variances**

$$
\begin{align}
&V[X + c] = V[X] &\text{ for all } c \in \mathbb R \\\\
&V[cX] = c^2\ E[X]  &\text{ for all } c \in \mathbb R
\end{align}
$$

- **Standard deviation**

$$
\sigma[X] = \sqrt{V[X]}
$$

The standard deviation is often preferable to the variance, since it is on the same scale as the random variable of interest.

Knowing these two quantities ($E[X]$ and $\sigma[X]$) tells *everything* about normal distributions.

- **The normal distribution**

$$X \sim \textsf{normal}(\mu, \sigma)$$

$$
E[X] = \mu \hspace{0.5cm} \text{ and } \hspace{0.5cm}
\sigma[X] = \sigma
$$

$$
f_X(x) = \frac{1}{\sigma \sqrt{2 \pi}} \exp\left(-\frac{1}{2 \sigma^2} (x - \mu)^2\right)
$$

Any linear combination of any number of mutually independent normal random variables must itself be normal.

$$
X \perp Y \to X + Y \sim \textsf{normal}\left(\mu_X + \mu_Y, \sqrt{\sigma_X^2 + \sigma_Y^2}\right)
$$

### Mean Squared Error

MSE is a metric that characterizes how well a random variable $X$ approximates a certain value $c$. 

$$MSE = E\left[(X - c)^2\right]$$

Note that the MSE about zero is the same as the _second raw moment_, and the MSE about $E[X]$ is the same as the _second central moment_, which is also the variance.

- **Root Mean Squared Error**

$$\sqrt{E\left[(X - c)^2\right]}$$

**Note**. This is used as a common measure of accuracy in the context of estimation.

- **Decomposition** 

$$
\begin{align}
E\left[(X - c)^2\right] &= E\left[(X^2 - 2cX + c^2\right] \\\\ &=
E\left[X^2\right] - 2cE[X] + c^2 \\\\ &=
E\left[X^2\right] \underbrace{- E[X]^2 + E[X]^2}_\text{clever trick} - 2cE[X] + c^2 \\\\ &= 
\left(E\left[X^2\right] - E[X]^2\right) + \left(E[X]^2 - 2cE[X] + c^2\right) \\\\ &=
V[X] + (E[X]-c)^2
\end{align}
$$

**Note.** In the context of estimation, this is also known as the bias-variance decomposition.

The MSE is also linked to an alternative definition of the mean: the value $c$ that minimizes the MSE of $X$ is $E[X]$.

$$
\underset{c \in \mathbb R}{\arg \min}\ E\left[(X - c)^2\right] = E[X]
$$

If we where to choose a different "loss function" besides the MSE, we could come up with different "best" choices for $c$. For example, the value $c$ that minimizes the Mean Absolute Error is the *median*.

****

## Summarizing joint distributions

****

### Covariance

Covariance measures the extent to which two random variables
"move together." 

$$
\begin{align}
\textsf{Cov}[X, Y] &= E\big[(X - E[X])(Y - E[Y])\big] \\\\ &=
E[XY] - E[X]E[Y]
\end{align}
$$

- **Variance Rule** (non-linearity of variances)

$$V[X + Y] = V[X] + \textsf{Cov}[X, Y] + V[Y]$$

- **Properties of Covariance**

****

## Bounds

From SN notes.

- **Markov's inequality**

- **Chebyshev's inequality**